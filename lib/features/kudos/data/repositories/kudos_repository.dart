import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/kudos/data/datasources/kudos_remote_datasource.dart';
import 'package:saa_mobile/features/kudos/data/models/department.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/kudos/data/models/secret_box.dart';
import 'package:saa_mobile/features/kudos/data/models/send_kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_data.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

class KudosRepository {
  KudosRepository(this._datasource);

  final KudosRemoteDatasource _datasource;

  Future<List<Kudos>> getKudos({
    int page = 1,
    int limit = 20,
    int? hashtagId,
    String? departmentName,
  }) async {
    try {
      final list = await _datasource.fetchKudos(
        page: page,
        limit: limit,
        hashtagId: hashtagId,
        departmentName: departmentName,
      );
      return list;
    } catch (e) {
      throw Exception('Không thể tải danh sách kudos: $e');
    }
  }

  Future<List<Kudos>> getHighlightKudos({
    int? hashtagId,
    String? departmentName,
  }) async {
    try {
      return await _datasource.fetchHighlightKudos(
        hashtagId: hashtagId,
        departmentName: departmentName,
      );
    } catch (e) {
      throw Exception('Không thể tải highlight kudos: $e');
    }
  }

  Future<Kudos> getKudosDetail(String kudosId) async {
    try {
      return await _datasource.fetchKudosDetail(kudosId);
    } catch (e) {
      throw Exception('Không thể tải chi tiết kudos: $e');
    }
  }

  Future<void> likeKudos(String kudosId) async {
    try {
      await _datasource.likeKudos(kudosId);
    } catch (e) {
      throw Exception('Không thể thả heart: $e');
    }
  }

  Future<void> unlikeKudos(String kudosId) async {
    try {
      await _datasource.unlikeKudos(kudosId);
    } catch (e) {
      throw Exception('Không thể bỏ heart: $e');
    }
  }

  Future<SpotlightData> getSpotlight() async {
    try {
      return await _datasource.fetchSpotlight();
    } catch (e) {
      throw Exception('Không thể tải spotlight: $e');
    }
  }

  Future<List<UserSummary>> searchSpotlight(String query) async {
    try {
      return await _datasource.searchSpotlight(query);
    } catch (e) {
      throw Exception('Không thể tìm kiếm: $e');
    }
  }

  Future<int> getTotalKudosCount() async {
    try {
      return await _datasource.fetchTotalKudosCount();
    } catch (e) {
      throw Exception('Không thể tải tổng kudos: $e');
    }
  }

  Future<PersonalStats> getPersonalStats() async {
    try {
      return await _datasource.fetchPersonalStats();
    } catch (e) {
      throw Exception('Không thể tải thống kê: $e');
    }
  }

  Future<List<GiftRecipientRanking>> getTopRecipients() async {
    try {
      return await _datasource.fetchTopRecipients();
    } catch (e) {
      throw Exception('Không thể tải top 10: $e');
    }
  }

  Future<List<Hashtag>> getHashtags() async {
    try {
      return await _datasource.fetchHashtags();
    } catch (e) {
      throw Exception('Không thể tải hashtags: $e');
    }
  }

  Future<List<Department>> getDepartments() async {
    try {
      return await _datasource.fetchDepartments();
    } catch (e) {
      throw Exception('Không thể tải phòng ban: $e');
    }
  }

  Future<List<UserSummary>> searchUsers(String query) async {
    try {
      return await _datasource.searchUsers(query);
    } catch (e) {
      throw Exception('Không thể tìm kiếm người dùng: $e');
    }
  }

  Future<List<UserSummary>> fetchAllUsers() async {
    try {
      return await _datasource.fetchAllUsers();
    } catch (e) {
      throw Exception('Không thể tải danh sách người dùng: $e');
    }
  }

  Future<String> createKudos({
    required int recipientId,
    required String title,
    required String message,
    required List<int> hashtagIds,
    List<String> imageUrls = const [],
    bool isAnonymous = false,
    String? senderAlias,
  }) async {
    try {
      return await _datasource.createKudos(
        recipientId: recipientId,
        title: title,
        message: message,
        hashtagIds: hashtagIds,
        imageUrls: imageUrls,
        isAnonymous: isAnonymous,
        senderAlias: senderAlias,
      );
    } catch (e) {
      throw Exception('Không thể gửi kudos: $e');
    }
  }

  Future<String> uploadKudosImage({
    required List<int> bytes,
    required String ext,
  }) async {
    try {
      return await _datasource.uploadKudosImageBytes(bytes, ext);
    } catch (e) {
      throw Exception('Không thể tải ảnh lên: $e');
    }
  }

  Future<void> deleteKudosImage(String imageUrl) async {
    try {
      await _datasource.deleteKudosImage(imageUrl);
    } catch (e) {
      throw Exception('Không thể xóa ảnh: $e');
    }
  }

  Future<void> upsertSendKudosDraft(SendKudosState draft) async {
    try {
      await _datasource.upsertSendKudosDraft(draft);
    } catch (e) {
      throw Exception('Không thể lưu nháp kudos: $e');
    }
  }

  Future<void> deleteSendKudosDraft() async {
    try {
      await _datasource.deleteSendKudosDraft();
    } catch (e) {
      throw Exception('Không thể xóa nháp kudos: $e');
    }
  }

  Future<SecretBox?> getNextSecretBox() async {
    try {
      return await _datasource.getNextSecretBox();
    } catch (e) {
      throw Exception('Không thể lấy hộp bí mật: $e');
    }
  }

  Future<SecretBox> openSecretBox(String boxId) async {
    try {
      return await _datasource.openSecretBox(boxId);
    } catch (e) {
      throw Exception('Không thể mở hộp bí mật: $e');
    }
  }

  Future<String?> getCurrentUserId() async {
    try {
      return await _datasource.tryGetCurrentUserStringId();
    } catch (_) {
      return null;
    }
  }
}

final kudosRepositoryProvider = Provider<KudosRepository>((ref) {
  final datasource = ref.watch(kudosRemoteDatasourceProvider);
  return KudosRepository(datasource);
});
