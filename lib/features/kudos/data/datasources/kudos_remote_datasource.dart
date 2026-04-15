import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/kudos/data/models/department.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/kudos/data/models/send_kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_network.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

/// PostgREST datasource — query Supabase tables trực tiếp.
/// Không dùng Edge Functions (chưa deploy).
class KudosRemoteDatasource {
  KudosRemoteDatasource(this._client);

  final SupabaseClient _client;

  // ─── SELECT helpers cho kudos with joins ───

  static const _kudosSelect = '''
    id,
    award_title,
    message,
    award_category_name,
    is_anonymous,
    sender_alias,
    status,
    created_at,
    sender:users!kudos_sender_id_fkey(id, name, avatar_url, hero_tier, hero_tier_url, department:departments(name)),
    recipient:users!kudos_recipient_id_fkey(id, name, avatar_url, hero_tier, hero_tier_url, department:departments(name)),
    hashtags:kudos_hashtags(hashtag:hashtags(id, name)),
    reactions:kudos_reactions(count),
    photos:kudos_photos(image_url, sort_order)
  ''';

  // ─── 1. List All Kudos (paginated) ───

  Future<List<Kudos>> fetchKudos({
    int page = 1,
    int limit = 20,
    int? hashtagId,
    String? departmentName,
  }) async {
    final data = await _client
        .from('kudos')
        .select(_kudosSelect)
        .eq('status', 'active')
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false)
        .range((page - 1) * limit, page * limit - 1);

    var results = (data as List)
        .map((e) => _mapKudos(e as Map<String, dynamic>))
        .toList();

    // Client-side filter khi hashtag/department được chọn
    if (hashtagId != null) {
      results = results
          .where((k) => k.hashtags.any((h) => h.id == hashtagId))
          .toList();
    }
    if (departmentName != null) {
      results = results
          .where(
            (k) =>
                k.sender.department == departmentName ||
                k.receiver.department == departmentName,
          )
          .toList();
    }

    return results;
  }

  // ─── 2. Highlight Kudos (top 5 by hearts) ───

  Future<List<Kudos>> fetchHighlightKudos({
    int? hashtagId,
    String? departmentName,
  }) async {
    // Lấy nhiều kudos gần đây, map ra model (có heartCount), rồi sort client-side
    // vì PostgREST không hỗ trợ ORDER BY count(related_table)
    final data = await _client
        .from('kudos')
        .select(_kudosSelect)
        .eq('status', 'active')
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false)
        .limit(50);

    var results = (data as List)
        .map((e) => _mapKudos(e as Map<String, dynamic>))
        .toList();

    // Client-side filter
    if (hashtagId != null) {
      results = results
          .where((k) => k.hashtags.any((h) => h.id == hashtagId))
          .toList();
    }
    if (departmentName != null) {
      results = results
          .where(
            (k) =>
                k.sender.department == departmentName ||
                k.receiver.department == departmentName,
          )
          .toList();
    }

    // Sort by heartCount DESC, lấy top 5
    results.sort((a, b) => b.heartCount.compareTo(a.heartCount));
    return results.take(5).toList();
  }

  // ─── 3. Kudos Detail ───

  Future<Kudos> fetchKudosDetail(String kudosId) async {
    final data = await _client
        .from('kudos')
        .select(_kudosSelect)
        .eq('id', int.parse(kudosId))
        .single();

    return _mapKudos(data);
  }

  // ─── 4. Like Kudos ───

  Future<void> likeKudos(String kudosId) async {
    final userId = await _getCurrentUserId();
    await _client.from('kudos_reactions').insert({
      'kudos_id': int.parse(kudosId),
      'user_id': userId,
    });
  }

  // ─── 5. Unlike Kudos ───

  Future<void> unlikeKudos(String kudosId) async {
    final userId = await _getCurrentUserId();
    await _client
        .from('kudos_reactions')
        .delete()
        .eq('kudos_id', int.parse(kudosId))
        .eq('user_id', userId);
  }

  // ─── 6. Spotlight Network ───

  Future<SpotlightNetwork> fetchSpotlight() async {
    // Lấy tất cả kudos active → build network graph client-side
    final kudosData = await _client
        .from('kudos')
        .select('sender_id, recipient_id')
        .eq('status', 'active')
        .isFilter('deleted_at', null);

    final usersData = await _client
        .from('users')
        .select('id, name, avatar_url')
        .isFilter('deleted_at', null);

    final totalCount = (kudosData as List).length;

    // Build nodes from users who sent or received kudos
    final involvedUserIds = <int>{};
    final edgeMap = <String, int>{};
    for (final k in kudosData) {
      final sid = k['sender_id'] as int;
      final rid = k['recipient_id'] as int;
      involvedUserIds.addAll([sid, rid]);
      final key = '$sid->$rid';
      edgeMap[key] = (edgeMap[key] ?? 0) + 1;
    }

    final nodes = <SpotlightNode>[];
    var i = 0;
    for (final u in (usersData as List)) {
      final uid = u['id'] as int;
      if (!involvedUserIds.contains(uid)) continue;
      // Simple circular layout
      final angle = (i / involvedUserIds.length) * math.pi * 2;
      nodes.add(
        SpotlightNode(
          userId: uid.toString(),
          name: u['name'] as String? ?? '',
          avatar: u['avatar_url'] as String? ?? '',
          x: 168 + 120 * math.cos(angle),
          y: 80 + 60 * math.sin(angle),
        ),
      );
      i++;
    }

    final edges = edgeMap.entries.map((e) {
      final parts = e.key.split('->');
      return SpotlightEdge(
        fromUserId: parts[0],
        toUserId: parts[1],
        weight: e.value,
      );
    }).toList();

    return SpotlightNetwork(nodes: nodes, edges: edges, totalKudos: totalCount);
  }

  // ─── 7. Search Spotlight ───

  Future<List<UserSummary>> searchSpotlight(String query) async {
    final data = await _client
        .from('users')
        .select(
          'id, name, avatar_url, hero_tier, hero_tier_url, department:departments(name)',
        )
        .ilike('name', '%$query%')
        .isFilter('deleted_at', null)
        .limit(20);

    return (data as List)
        .map((e) => _mapUserSummary(e as Map<String, dynamic>))
        .toList();
  }

  // ─── 8. Total Kudos Count ───

  Future<int> fetchTotalKudosCount() async {
    final result = await _client
        .from('kudos')
        .select('id')
        .eq('status', 'active')
        .isFilter('deleted_at', null)
        .count(CountOption.exact);

    return result.count;
  }

  // ─── 9. Personal Stats ───

  Future<PersonalStats> fetchPersonalStats() async {
    final userId = await _tryGetCurrentUserId();
    if (userId == null) return const PersonalStats();

    final data = await _client
        .from('user_stats')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (data == null) return const PersonalStats();

    return PersonalStats(
      kudosReceived: data['kudos_received_count'] as int? ?? 0,
      kudosSent: data['kudos_sent_count'] as int? ?? 0,
      heartsReceived: data['hearts_received_count'] as int? ?? 0,
      secretBoxesOpened: data['secret_boxes_opened'] as int? ?? 0,
      secretBoxesUnopened: data['secret_boxes_unopened'] as int? ?? 0,
    );
  }

  // ─── 10. Top Recipients ───

  Future<List<GiftRecipientRanking>> fetchTopRecipients() async {
    // 10 sunner nhận quà mới nhất — sort by created_at DESC, unique recipients
    final data = await _client
        .from('kudos')
        .select(
          'recipient_id, created_at, award_category_name, recipient:users!kudos_recipient_id_fkey(id, name, avatar_url, hero_tier, hero_tier_url, department:departments(name))',
        )
        .eq('status', 'active')
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false);

    // Lấy unique recipients theo thứ tự mới nhất
    final seen = <int>{};
    final results = <GiftRecipientRanking>[];
    var rank = 1;

    for (final row in (data as List)) {
      final rid = row['recipient_id'] as int;
      if (seen.contains(rid)) continue;
      seen.add(rid);

      results.add(
        GiftRecipientRanking(
          rank: rank,
          user: _mapUserSummary(row['recipient'] as Map<String, dynamic>),
          rewardName: row['award_category_name'] as String? ?? '',
        ),
      );
      rank++;
      if (results.length >= 10) break;
    }

    return results;
  }

  // ─── 11. Hashtags ───

  Future<List<Hashtag>> fetchHashtags() async {
    final data = await _client
        .from('hashtags')
        .select('id, name')
        .order('name');

    return (data as List)
        .map((e) => Hashtag(id: e['id'] as int, name: e['name'] as String))
        .toList();
  }

  // ─── 12. Departments ───

  Future<List<Department>> fetchDepartments() async {
    final data = await _client
        .from('departments')
        .select('id, name')
        .order('name');

    return (data as List)
        .map((e) => Department(id: e['id'] as int, name: e['name'] as String))
        .toList();
  }

  // ─── 13. Search Users ───

  Future<List<UserSummary>> searchUsers(String query) async {
    final data = await _client
        .from('users')
        .select(
          'id, name, avatar_url, hero_tier, hero_tier_url, department:departments(name)',
        )
        .ilike('name', '%$query%')
        .isFilter('deleted_at', null)
        .limit(20);

    return (data as List)
        .map((e) => _mapUserSummary(e as Map<String, dynamic>))
        .toList();
  }

  // ─── 13b. Fetch All Users (for PopupMenu) ───

  Future<List<UserSummary>> fetchAllUsers() async {
    final data = await _client
        .from('users')
        .select(
          'id, name, avatar_url, hero_tier, hero_tier_url, department:departments(name)',
        )
        .isFilter('deleted_at', null)
        .order('name');

    return (data as List)
        .map((e) => _mapUserSummary(e as Map<String, dynamic>))
        .toList();
  }

  // ─── 14. Create Kudos ───

  Future<String> createKudos({
    required int recipientId,
    required String title,
    required String message,
    required List<int> hashtagIds,
    List<String> imageUrls = const [],
    bool isAnonymous = false,
    String? senderAlias,
  }) async {
    final senderId = await _getCurrentUserId();

    // Insert kudos
    final kudosData = await _client
        .from('kudos')
        .insert({
          'sender_id': senderId,
          'recipient_id': recipientId,
          'award_title': title,
          'message': message,
          'is_anonymous': isAnonymous,
          if (senderAlias != null && senderAlias.isNotEmpty)
            'sender_alias': senderAlias,
          'status': 'active',
        })
        .select('id')
        .single();

    final kudosId = kudosData['id'] as int;

    // Insert hashtag associations
    if (hashtagIds.isNotEmpty) {
      await _client
          .from('kudos_hashtags')
          .insert(
            hashtagIds
                .map((hid) => {'kudos_id': kudosId, 'hashtag_id': hid})
                .toList(),
          );
    }

    // Insert photo associations
    if (imageUrls.isNotEmpty) {
      await _client
          .from('kudos_photos')
          .insert(
            imageUrls
                .asMap()
                .entries
                .map(
                  (e) => {
                    'kudos_id': kudosId,
                    'image_url': e.value,
                    'sort_order': e.key,
                  },
                )
                .toList(),
          );
    }

    return '$kudosId';
  }

  // ─── 15. Upload Kudos Image ───

  Future<String> uploadKudosImage(String filePath) async {
    throw UnimplementedError('Use uploadKudosImageBytes instead');
  }

  Future<String> uploadKudosImageBytes(List<int> bytes, String ext) async {
    final userId = await _getCurrentUserId();
    final fileName = '$userId/${DateTime.now().millisecondsSinceEpoch}.$ext';

    await _client.storage
        .from('kudos-photos')
        .uploadBinary(
          fileName,
          bytes is Uint8List ? bytes : Uint8List.fromList(bytes),
          fileOptions: FileOptions(contentType: 'image/$ext', upsert: false),
        );

    return _client.storage.from('kudos-photos').getPublicUrl(fileName);
  }

  // ─── 16. Delete Kudos Image ───

  Future<void> deleteKudosImage(String imageUrl) async {
    // Extract path from public URL: .../storage/v1/object/public/kudos-photos/{path}
    final uri = Uri.parse(imageUrl);
    final segments = uri.pathSegments;
    final bucketIndex = segments.indexOf('kudos-photos');
    if (bucketIndex == -1 || bucketIndex == segments.length - 1) return;

    final filePath = segments.sublist(bucketIndex + 1).join('/');
    await _client.storage.from('kudos-photos').remove([filePath]);
  }

  Future<void> upsertSendKudosDraft(SendKudosState draft) async {
    final senderId = await _getCurrentUserId();
    final recipientId = int.tryParse(draft.recipientId ?? '');

    await _client.from('kudos_drafts').upsert({
      'sender_id': senderId,
      'recipient_id': recipientId,
      'award_title': draft.title,
      'message': draft.message,
      'is_anonymous': draft.isAnonymous,
      'hashtag_ids': draft.hashtags.map((h) => h.id).toList(),
      'image_urls': draft.imagePreviews,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'sender_id');
  }

  Future<void> deleteSendKudosDraft() async {
    final senderId = await _getCurrentUserId();
    await _client.from('kudos_drafts').delete().eq('sender_id', senderId);
  }

  // ─── Helpers ───

  Future<int> _getCurrentUserId() async {
    final userId = await _tryGetCurrentUserId();
    if (userId == null) throw Exception('Chưa đăng nhập');
    return userId;
  }

  /// Trả null thay vì throw nếu user chưa login hoặc chưa có profile.
  Future<String?> tryGetCurrentUserStringId() async {
    final id = await _tryGetCurrentUserId();
    return id?.toString();
  }

  /// Trả null thay vì throw nếu user chưa login hoặc chưa có profile.
  Future<int?> _tryGetCurrentUserId() async {
    final authUser = _client.auth.currentUser;
    if (authUser == null) return null;

    final data = await _client
        .from('users')
        .select('id')
        .eq('auth_id', authUser.id)
        .maybeSingle();

    return data?['id'] as int?;
  }

  Kudos _mapKudos(Map<String, dynamic> data) {
    final sender = data['sender'] as Map<String, dynamic>?;
    final recipient = data['recipient'] as Map<String, dynamic>?;
    final hashtagJoin = data['hashtags'] as List? ?? [];
    final reactions = data['reactions'] as List? ?? [];
    final photos = data['photos'] as List? ?? [];

    final hashtags = hashtagJoin
        .map((h) {
          final ht = h['hashtag'] as Map<String, dynamic>?;
          if (ht == null) return null;
          return Hashtag(id: ht['id'] as int, name: ht['name'] as String);
        })
        .whereType<Hashtag>()
        .toList();

    final imageUrls =
        (photos..sort(
              (a, b) => ((a['sort_order'] as int?) ?? 0).compareTo(
                (b['sort_order'] as int?) ?? 0,
              ),
            ))
            .map((p) => p['image_url'] as String? ?? '')
            .where((url) => url.isNotEmpty)
            .toList();

    return Kudos(
      id: '${data['id']}',
      sender: sender != null
          ? _mapUserSummary(sender)
          : const UserSummary(id: '0', name: 'Unknown'),
      receiver: recipient != null
          ? _mapUserSummary(recipient)
          : const UserSummary(id: '0', name: 'Unknown'),
      content: data['message'] as String? ?? '',
      hashtags: hashtags,
      heartCount: reactions.isNotEmpty
          ? (reactions.first['count'] as int? ?? 0)
          : 0,
      createdAt:
          DateTime.tryParse(data['created_at'] as String? ?? '') ??
          DateTime.now(),
      isAnonymous: data['is_anonymous'] as bool? ?? false,
      senderAlias: data['sender_alias'] as String?,
      shareUrl: 'saa://kudos/${data['id']}',
      awardTitle: data['award_title'] as String?,
      imageUrls: imageUrls,
    );
  }

  UserSummary _mapUserSummary(Map<String, dynamic> data) {
    final dept = data['department'];
    String deptName = '';
    if (dept is Map<String, dynamic>) {
      deptName = dept['name'] as String? ?? '';
    } else if (dept is List && dept.isNotEmpty) {
      deptName = (dept.first as Map<String, dynamic>)['name'] as String? ?? '';
    }

    final heroTier = data['hero_tier'] as String? ?? 'none';
    final badgeLevel = switch (heroTier) {
      'new_hero' => 1,
      'rising_hero' => 2,
      'super_hero' => 3,
      'legend_hero' => 4,
      _ => 0,
    };

    return UserSummary(
      id: '${data['id']}',
      name: data['name'] as String? ?? '',
      avatar: data['avatar_url'] as String? ?? '',
      department: deptName,
      badgeLevel: badgeLevel,
      heroTierUrl: data['hero_tier_url'] as String? ?? '',
    );
  }
}

final kudosRemoteDatasourceProvider = Provider<KudosRemoteDatasource>((ref) {
  return KudosRemoteDatasource(Supabase.instance.client);
});
