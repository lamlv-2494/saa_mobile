import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/profile/data/models/badge.dart';
import 'package:saa_mobile/features/profile/data/models/icon_badge.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';
import 'package:saa_mobile/features/profile/data/repositories/profile_repository.dart';

import '../../helpers/profile_mocks.dart';
import '../../helpers/profile_test_helpers.dart';
import '../../helpers/kudos_test_helpers.dart';

void main() {
  late MockProfileRemoteDatasource mockDatasource;
  late ProfileRepository repo;

  final testProfile = createUserProfile();
  final testIconBadges = createIconBadgeList(count: 3);
  final testBadges = createBadgeList(count: 2);
  final testStats = createPersonalStats();
  final testKudos = createKudosFeedList(count: 5);
  final testSearchResults = [
    createUserProfile(id: '1', name: 'Nguyễn Văn A'),
    createUserProfile(id: '2', name: 'Nguyễn Thị B'),
  ];

  setUp(() {
    mockDatasource = MockProfileRemoteDatasource();
    repo = ProfileRepository(mockDatasource);
  });

  // ─── getMyProfile ───

  group('getMyProfile', () {
    test('trả về UserProfile khi thành công', () async {
      when(() => mockDatasource.fetchMyProfile())
          .thenAnswer((_) async => testProfile);

      final result = await repo.getMyProfile();

      expect(result, testProfile);
      verify(() => mockDatasource.fetchMyProfile()).called(1);
    });

    test('throw Exception khi có lỗi', () async {
      when(() => mockDatasource.fetchMyProfile())
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.getMyProfile(),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── getUserProfile ───

  group('getUserProfile', () {
    test('trả về UserProfile theo userId', () async {
      when(() => mockDatasource.fetchUserProfile('2'))
          .thenAnswer((_) async => testProfile);

      final result = await repo.getUserProfile('2');

      expect(result, testProfile);
      verify(() => mockDatasource.fetchUserProfile('2')).called(1);
    });

    test('throw Exception khi có lỗi', () async {
      when(() => mockDatasource.fetchUserProfile('999'))
          .thenThrow(Exception('Not found'));

      expect(
        () => repo.getUserProfile('999'),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── getMyIconBadges ───

  group('getMyIconBadges', () {
    test('trả về List<IconBadge> khi thành công', () async {
      when(() => mockDatasource.fetchMyIconBadges())
          .thenAnswer((_) async => testIconBadges);

      final result = await repo.getMyIconBadges();

      expect(result, testIconBadges);
      expect(result.length, 3);
    });

    test('trả về danh sách rỗng khi không có badges', () async {
      when(() => mockDatasource.fetchMyIconBadges())
          .thenAnswer((_) async => <IconBadge>[]);

      final result = await repo.getMyIconBadges();

      expect(result, isEmpty);
    });

    test('throw Exception khi có lỗi', () async {
      when(() => mockDatasource.fetchMyIconBadges())
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.getMyIconBadges(),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── getUserBadges ───

  group('getUserBadges', () {
    test('trả về List<Badge> theo userId', () async {
      when(() => mockDatasource.fetchUserBadges('2'))
          .thenAnswer((_) async => testBadges);

      final result = await repo.getUserBadges('2');

      expect(result, testBadges);
      expect(result.length, 2);
    });

    test('trả về danh sách rỗng khi user không có badge', () async {
      when(() => mockDatasource.fetchUserBadges('3'))
          .thenAnswer((_) async => <Badge>[]);

      final result = await repo.getUserBadges('3');

      expect(result, isEmpty);
    });

    test('throw Exception khi có lỗi', () async {
      when(() => mockDatasource.fetchUserBadges('2'))
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.getUserBadges('2'),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── getMyStats ───

  group('getMyStats', () {
    test('trả về PersonalStats khi thành công', () async {
      when(() => mockDatasource.fetchMyStats())
          .thenAnswer((_) async => testStats);

      final result = await repo.getMyStats();

      expect(result, testStats);
      expect(result.kudosReceived, 25);
    });

    test('throw Exception khi có lỗi', () async {
      when(() => mockDatasource.fetchMyStats())
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.getMyStats(),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── getKudosHistory ───

  group('getKudosHistory', () {
    test('trả về List<Kudos> với filter sent', () async {
      when(() => mockDatasource.fetchKudosHistory(
            userId: '1',
            filter: 'sent',
            page: 1,
            limit: 20,
          )).thenAnswer((_) async => testKudos);

      final result = await repo.getKudosHistory(
        userId: '1',
        filter: 'sent',
      );

      expect(result, testKudos);
      expect(result.length, 5);
    });

    test('trả về List<Kudos> với filter received', () async {
      when(() => mockDatasource.fetchKudosHistory(
            userId: '1',
            filter: 'received',
            page: 1,
            limit: 20,
          )).thenAnswer((_) async => testKudos);

      final result = await repo.getKudosHistory(
        userId: '1',
        filter: 'received',
      );

      expect(result, testKudos);
    });

    test('hỗ trợ phân trang', () async {
      when(() => mockDatasource.fetchKudosHistory(
            userId: '1',
            filter: 'sent',
            page: 2,
            limit: 10,
          )).thenAnswer((_) async => testKudos.take(3).toList());

      final result = await repo.getKudosHistory(
        userId: '1',
        filter: 'sent',
        page: 2,
        limit: 10,
      );

      expect(result.length, 3);
    });

    test('trả về danh sách rỗng khi không có kudos', () async {
      when(() => mockDatasource.fetchKudosHistory(
            userId: '1',
            filter: 'sent',
            page: 1,
            limit: 20,
          )).thenAnswer((_) async => <Kudos>[]);

      final result = await repo.getKudosHistory(
        userId: '1',
        filter: 'sent',
      );

      expect(result, isEmpty);
    });

    test('throw Exception khi có lỗi', () async {
      when(() => mockDatasource.fetchKudosHistory(
            userId: '1',
            filter: 'sent',
            page: 1,
            limit: 20,
          )).thenThrow(Exception('Network error'));

      expect(
        () => repo.getKudosHistory(userId: '1', filter: 'sent'),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── searchUsers ───

  group('searchUsers', () {
    test('trả về List<UserProfile> theo query', () async {
      when(() => mockDatasource.searchUsers('Nguyễn'))
          .thenAnswer((_) async => testSearchResults);

      final result = await repo.searchUsers('Nguyễn');

      expect(result, testSearchResults);
      expect(result.length, 2);
    });

    test('trả về danh sách rỗng khi không tìm thấy', () async {
      when(() => mockDatasource.searchUsers('XYZ'))
          .thenAnswer((_) async => <UserProfile>[]);

      final result = await repo.searchUsers('XYZ');

      expect(result, isEmpty);
    });

    test('throw Exception khi có lỗi', () async {
      when(() => mockDatasource.searchUsers('test'))
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.searchUsers('test'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
