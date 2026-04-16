import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';
import 'package:saa_mobile/features/profile/data/models/badge.dart';
import 'package:saa_mobile/features/profile/data/models/icon_badge.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';

/// Datasource cho Profile feature — query Supabase tables trực tiếp.
class ProfileRemoteDatasource {
  ProfileRemoteDatasource(this._client);

  final SupabaseClient _client;

  // ─── SELECT helpers cho profile ───

  static const _profileSelect = '''
    id,
    name,
    email,
    avatar_url,
    hero_tier,
    team_code,
    department:departments(name)
  ''';

  static const _kudosSelect = '''
    id,
    award_title,
    message,
    award_category_name,
    is_anonymous,
    status,
    created_at,
    sender:users!kudos_sender_id_fkey(id, name, avatar_url, hero_tier, department:departments(name)),
    recipient:users!kudos_recipient_id_fkey(id, name, avatar_url, hero_tier, department:departments(name)),
    hashtags:kudos_hashtags(hashtag:hashtags(id, name)),
    reactions:kudos_reactions(count),
    photos:kudos_photos(image_url, sort_order)
  ''';

  // ─── 1. Lấy profile bản thân ───

  Future<UserProfile> fetchMyProfile() async {
    final userId = await _getCurrentUserId();
    final data = await _client
        .from('users')
        .select(_profileSelect)
        .eq('id', userId)
        .single();

    return _mapUserProfile(data);
  }

  // ─── 2. Lấy profile người khác ───

  Future<UserProfile> fetchUserProfile(String userId) async {
    final data = await _client
        .from('users')
        .select(_profileSelect)
        .eq('id', int.parse(userId))
        .single();

    return _mapUserProfile(data);
  }

  // ─── 3. Lấy icon badges bản thân ───

  Future<List<IconBadge>> fetchMyIconBadges() async {
    final userId = await _getCurrentUserId();
    final data = await _client
        .from('user_badges')
        .select('badge:badges(id, name, image_url), earned_at')
        .eq('user_id', userId)
        .order('earned_at', ascending: false);

    return (data as List).map((row) {
      final badge = row['badge'] as Map<String, dynamic>;
      return IconBadge(
        badgeId: badge['id'] as int,
        badgeName: badge['name'] as String,
        badgeImageUrl: badge['image_url'] as String? ?? '',
        earnedAt: DateTime.tryParse(row['earned_at'] as String? ?? ''),
      );
    }).toList();
  }

  // ─── 4. Lấy badges người khác (có tên) ───

  Future<List<Badge>> fetchUserBadges(String userId) async {
    final data = await _client
        .from('user_badges')
        .select('badge:badges(id, name, image_url, description)')
        .eq('user_id', int.parse(userId))
        .order('earned_at', ascending: false);

    return (data as List).map((row) {
      final badge = row['badge'] as Map<String, dynamic>;
      return Badge(
        id: badge['id'] as int,
        name: badge['name'] as String,
        imageUrl: badge['image_url'] as String? ?? '',
        description: badge['description'] as String?,
      );
    }).toList();
  }

  // ─── 5. Thống kê cá nhân (reuse logic từ KudosRemoteDatasource) ───

  Future<PersonalStats> fetchMyStats() async {
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

  // ─── 5b. Thống kê người dùng khác ───

  Future<PersonalStats> fetchUserStats(String userId) async {
    final data = await _client
        .from('user_stats')
        .select()
        .eq('user_id', int.parse(userId))
        .maybeSingle();

    if (data == null) return const PersonalStats();

    return PersonalStats(
      kudosReceived: data['kudos_received_count'] as int? ?? 0,
      kudosSent: data['kudos_sent_count'] as int? ?? 0,
      heartsReceived: data['hearts_received_count'] as int? ?? 0,
    );
  }

  // ─── 6. Lịch sử kudos (phân trang + filter sent/received) ───

  Future<List<Kudos>> fetchKudosHistory({
    required String userId,
    required String filter,
    int page = 1,
    int limit = 20,
  }) async {
    final idInt = int.parse(userId);
    final filterColumn = filter == 'sent' ? 'sender_id' : 'recipient_id';

    final data = await _client
        .from('kudos')
        .select(_kudosSelect)
        .eq(filterColumn, idInt)
        .eq('status', 'active')
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false)
        .range((page - 1) * limit, page * limit - 1);

    return (data as List)
        .map((e) => _mapKudos(e as Map<String, dynamic>))
        .toList();
  }

  // ─── 7. Tìm kiếm users ───

  Future<List<UserProfile>> searchUsers(String query) async {
    final data = await _client
        .from('users')
        .select(_profileSelect)
        .ilike('name', '%$query%')
        .isFilter('deleted_at', null)
        .limit(20);

    return (data as List)
        .map((e) => _mapUserProfile(e as Map<String, dynamic>))
        .toList();
  }

  // ─── Helpers ───

  Future<int> _getCurrentUserId() async {
    final userId = await _tryGetCurrentUserId();
    if (userId == null) throw Exception('Chưa đăng nhập');
    return userId;
  }

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

  UserProfile _mapUserProfile(Map<String, dynamic> data) {
    final dept = data['department'];
    String deptName = '';
    if (dept is Map<String, dynamic>) {
      deptName = dept['name'] as String? ?? '';
    } else if (dept is List && dept.isNotEmpty) {
      deptName = (dept.first as Map<String, dynamic>)['name'] as String? ?? '';
    }

    return UserProfile(
      id: '${data['id']}',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
      teamCode: data['team_code'] as String?,
      departmentName: deptName.isEmpty ? null : deptName,
      heroTier: data['hero_tier'] as String? ?? 'none',
    );
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
      heroTier: heroTier,
    );
  }
}

final profileRemoteDatasourceProvider = Provider<ProfileRemoteDatasource>((
  ref,
) {
  return ProfileRemoteDatasource(Supabase.instance.client);
});
