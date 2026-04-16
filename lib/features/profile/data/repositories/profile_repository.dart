import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:saa_mobile/features/profile/data/models/badge.dart';
import 'package:saa_mobile/features/profile/data/models/icon_badge.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';

class ProfileRepository {
  ProfileRepository(this._datasource);

  final ProfileRemoteDatasource _datasource;

  Future<UserProfile> getMyProfile() async {
    try {
      return await _datasource.fetchMyProfile();
    } catch (e) {
      throw Exception('Không thể tải profile: $e');
    }
  }

  Future<UserProfile> getUserProfile(String userId) async {
    try {
      return await _datasource.fetchUserProfile(userId);
    } catch (e) {
      throw Exception('Không thể tải profile người dùng: $e');
    }
  }

  Future<List<IconBadge>> getMyIconBadges() async {
    try {
      return await _datasource.fetchMyIconBadges();
    } catch (e) {
      throw Exception('Không thể tải bộ sưu tập icon: $e');
    }
  }

  Future<List<Badge>> getUserBadges(String userId) async {
    try {
      return await _datasource.fetchUserBadges(userId);
    } catch (e) {
      throw Exception('Không thể tải huy hiệu: $e');
    }
  }

  Future<PersonalStats> getMyStats() async {
    try {
      return await _datasource.fetchMyStats();
    } catch (e) {
      throw Exception('Không thể tải thống kê: $e');
    }
  }

  Future<PersonalStats> getUserStats(String userId) async {
    try {
      return await _datasource.fetchUserStats(userId);
    } catch (e) {
      return const PersonalStats();
    }
  }

  Future<List<Kudos>> getKudosHistory({
    required String userId,
    required String filter,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      return await _datasource.fetchKudosHistory(
        userId: userId,
        filter: filter,
        page: page,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Không thể tải lịch sử kudos: $e');
    }
  }

  Future<List<UserProfile>> searchUsers(String query) async {
    try {
      return await _datasource.searchUsers(query);
    } catch (e) {
      throw Exception('Không thể tìm kiếm người dùng: $e');
    }
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final datasource = ref.watch(profileRemoteDatasourceProvider);
  return ProfileRepository(datasource);
});
