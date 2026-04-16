import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';
import 'package:saa_mobile/features/profile/data/models/badge.dart';
import 'package:saa_mobile/features/profile/data/models/icon_badge.dart';
import 'package:saa_mobile/features/profile/data/models/kudos_filter_type.dart';
import 'package:saa_mobile/features/profile/data/models/profile_state.dart';
import 'package:saa_mobile/features/profile/data/models/other_profile_state.dart';

void main() {
  group('UserProfile', () {
    test('fromJson tạo đúng model', () {
      final json = {
        'id': '1',
        'name': 'Nguyễn Văn A',
        'email': 'a@sun-asterisk.com',
        'avatarUrl': 'https://example.com/avatar.png',
        'teamCode': 'TEAM-01',
        'departmentName': 'CECV1',
        'heroTier': 'rising_hero',
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.id, '1');
      expect(profile.name, 'Nguyễn Văn A');
      expect(profile.email, 'a@sun-asterisk.com');
      expect(profile.avatarUrl, 'https://example.com/avatar.png');
      expect(profile.teamCode, 'TEAM-01');
      expect(profile.departmentName, 'CECV1');
      expect(profile.heroTier, 'rising_hero');
    });

    test('toJson round-trip', () {
      const profile = UserProfile(
        id: '1',
        name: 'Test User',
        email: 'test@test.com',
        teamCode: 'TEAM-01',
        departmentName: 'CECV1',
        heroTier: 'new_hero',
      );

      final json = profile.toJson();
      final restored = UserProfile.fromJson(json);

      expect(restored, profile);
    });

    test('avatarUrl nullable', () {
      const profile = UserProfile(
        id: '1',
        name: 'No Avatar',
        email: 'test@test.com',
        heroTier: 'none',
      );

      expect(profile.avatarUrl, isNull);
    });
  });

  group('Badge', () {
    test('fromJson tạo đúng model', () {
      final json = {
        'id': 1,
        'name': 'Rising Hero',
        'imageUrl': '/badges/rising.png',
        'description': 'Nhận 20 Kudos',
      };

      final badge = Badge.fromJson(json);

      expect(badge.id, 1);
      expect(badge.name, 'Rising Hero');
      expect(badge.imageUrl, '/badges/rising.png');
    });
  });

  group('IconBadge', () {
    test('fromJson tạo đúng model', () {
      final json = {
        'badgeId': 2,
        'badgeName': 'Rising Hero',
        'badgeImageUrl': '/badges/rising.png',
        'earnedAt': '2026-03-14T11:56:44.701371+00:00',
      };

      final iconBadge = IconBadge.fromJson(json);

      expect(iconBadge.badgeId, 2);
      expect(iconBadge.badgeName, 'Rising Hero');
      expect(iconBadge.earnedAt, isNotNull);
    });
  });

  group('KudosFilterType', () {
    test('có 2 giá trị: received và sent', () {
      expect(KudosFilterType.values.length, 2);
      expect(KudosFilterType.values, contains(KudosFilterType.received));
      expect(KudosFilterType.values, contains(KudosFilterType.sent));
    });
  });

  group('ProfileState', () {
    test('default values', () {
      const state = ProfileState();

      expect(state.kudosList, isEmpty);
      expect(state.iconBadges, isEmpty);
      expect(state.kudosFilter, KudosFilterType.received);
      expect(state.hasMoreKudos, true);
      expect(state.isLoadingMoreKudos, false);
      expect(state.profile, isNull);
      expect(state.personalStats, isNull);
    });

    test('copyWith cập nhật kudosFilter', () {
      const state = ProfileState();
      final updated = state.copyWith(kudosFilter: KudosFilterType.sent);

      expect(updated.kudosFilter, KudosFilterType.sent);
      expect(state.kudosFilter, KudosFilterType.received);
    });
  });

  group('OtherProfileState', () {
    test('default values', () {
      const state = OtherProfileState();

      expect(state.kudosList, isEmpty);
      expect(state.badges, isEmpty);
      expect(state.kudosFilter, KudosFilterType.received);
      expect(state.hasMoreKudos, true);
      expect(state.profile, isNull);
    });

    test('copyWith cập nhật filter', () {
      const state = OtherProfileState();
      final updated = state.copyWith(kudosFilter: KudosFilterType.sent);

      expect(updated.kudosFilter, KudosFilterType.sent);
    });
  });
}
