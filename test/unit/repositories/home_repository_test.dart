import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/features/home/data/models/event_info.dart';
import 'package:saa_mobile/features/home/data/models/kudos_info.dart';
import 'package:saa_mobile/features/home/data/repositories/home_repository.dart';

import '../../helpers/home_mocks.dart';

void main() {
  late MockHomeRemoteDatasource mockDatasource;
  late HomeRepositoryImpl repo;

  final testEventInfo = EventInfo(
    themeName: 'Root Further',
    eventDate: DateTime(2025, 12, 26),
    venue: 'Âu Cơ Art Center',
    livestreamNote: 'Livestream tại Facebook',
    themeDescription: 'Mô tả test',
  );

  const testAwards = [
    AwardCategory(id: 1, name: 'Top Talent', description: 'Desc 1'),
    AwardCategory(id: 2, name: 'Top Project', description: 'Desc 2'),
  ];

  const testKudosInfo = KudosInfo(
    bannerImageUrl: '',
    title: 'Sun* Kudos',
    description: 'Desc',
    isEnabled: true,
  );

  setUp(() {
    mockDatasource = MockHomeRemoteDatasource();
    repo = HomeRepositoryImpl(mockDatasource);
  });

  group('getEventInfo', () {
    test('returns EventInfo on success', () async {
      when(() => mockDatasource.getEventInfo(locale: 'vi'))
          .thenAnswer((_) async => testEventInfo);

      final result = await repo.getEventInfo(locale: 'vi');

      expect(result, testEventInfo);
      verify(() => mockDatasource.getEventInfo(locale: 'vi')).called(1);
    });

    test('propagates exception on error', () async {
      when(() => mockDatasource.getEventInfo(locale: 'vi'))
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.getEventInfo(locale: 'vi'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getAwardCategories', () {
    test('returns list of AwardCategory on success', () async {
      when(() => mockDatasource.getAwardCategories(locale: 'vi'))
          .thenAnswer((_) async => testAwards);

      final result = await repo.getAwardCategories(locale: 'vi');

      expect(result, testAwards);
      expect(result.length, 2);
    });

    test('returns empty list when no awards', () async {
      when(() => mockDatasource.getAwardCategories(locale: 'vi'))
          .thenAnswer((_) async => []);

      final result = await repo.getAwardCategories(locale: 'vi');

      expect(result, isEmpty);
    });

    test('propagates exception on error', () async {
      when(() => mockDatasource.getAwardCategories(locale: 'vi'))
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.getAwardCategories(locale: 'vi'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getKudosInfo', () {
    test('returns KudosInfo on success', () async {
      when(() => mockDatasource.getKudosInfo())
          .thenAnswer((_) async => testKudosInfo);

      final result = await repo.getKudosInfo();

      expect(result, testKudosInfo);
      expect(result.isEnabled, true);
    });

    test('propagates exception on error', () async {
      when(() => mockDatasource.getKudosInfo())
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.getKudosInfo(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getUnreadNotificationCount', () {
    test('returns count on success', () async {
      when(() => mockDatasource.getUnreadNotificationCount())
          .thenAnswer((_) async => 5);

      final result = await repo.getUnreadNotificationCount();

      expect(result, 5);
    });

    test('returns zero when no unread', () async {
      when(() => mockDatasource.getUnreadNotificationCount())
          .thenAnswer((_) async => 0);

      final result = await repo.getUnreadNotificationCount();

      expect(result, 0);
    });

    test('propagates exception on error', () async {
      when(() => mockDatasource.getUnreadNotificationCount())
          .thenThrow(Exception('Network error'));

      expect(
        () => repo.getUnreadNotificationCount(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
