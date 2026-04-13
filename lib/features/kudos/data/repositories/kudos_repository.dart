import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/kudos/data/datasources/kudos_remote_datasource.dart';
import 'package:saa_mobile/features/kudos/data/models/department.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_network.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

class KudosRepository {
  KudosRepository(this._datasource);

  final KudosRemoteDatasource _datasource;

  Future<List<Kudos>> getKudos({
    int page = 1,
    int limit = 20,
    int? hashtagId,
    int? departmentId,
  }) async {
    try {
      return await _datasource.fetchKudos(
        page: page,
        limit: limit,
        hashtagId: hashtagId,
        departmentId: departmentId,
      );
    } catch (e) {
      throw Exception('Không thể tải danh sách kudos: $e');
    }
  }

  Future<List<Kudos>> getHighlightKudos({
    int? hashtagId,
    int? departmentId,
  }) async {
    try {
      return await _datasource.fetchHighlightKudos(
        hashtagId: hashtagId,
        departmentId: departmentId,
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

  Future<SpotlightNetwork> getSpotlight() async {
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
}

final kudosRepositoryProvider = Provider<KudosRepository>((ref) {
  final datasource = ref.watch(kudosRemoteDatasourceProvider);
  return KudosRepository(datasource);
});
