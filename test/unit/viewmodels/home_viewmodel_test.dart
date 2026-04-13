import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/features/home/data/models/event_info.dart';
import 'package:saa_mobile/features/home/data/models/home_state.dart';
import 'package:saa_mobile/features/home/data/models/kudos_info.dart';
import 'package:saa_mobile/features/home/data/repositories/home_repository.dart';
import 'package:saa_mobile/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

import '../../helpers/home_mocks.dart';

void main() {
  late MockHomeRepository mockRepo;

  final testEventInfo = EventInfo(
    themeName: 'Root Further',
    eventDate: DateTime(2025, 12, 26),
    venue: 'Âu Cơ Art Center',
    livestreamNote: 'Livestream tại Facebook',
    themeDescription: 'Mô tả chủ đề test',
  );

  const testAwards = [
    AwardCategory(id: 1, name: 'Top Talent', description: 'Desc'),
    AwardCategory(id: 2, name: 'Top Project', description: 'Desc 2'),
  ];

  const testKudosInfo = KudosInfo(
    title: 'Sun* Kudos',
    description: 'Desc',
    isEnabled: true,
  );

  setUp(() {
    mockRepo = MockHomeRepository();
  });

  ProviderContainer createContainer() {
    SharedPreferences.setMockInitialValues({});
    return ProviderContainer(
      overrides: [
        homeRepositoryProvider.overrideWithValue(mockRepo),
        localeNotifierProvider.overrideWith((_) => LocaleNotifier(
          SharedPreferences.getInstance() as SharedPreferences,
        )),
        // Override locale directly to avoid SharedPreferences async init
        localeNotifierProvider.overrideWith((ref) {
          return _FakeLocaleNotifier();
        }),
      ],
    );
  }

  void stubAllSuccess() {
    when(() => mockRepo.getEventInfo(locale: any(named: 'locale')))
        .thenAnswer((_) async => testEventInfo);
    when(() => mockRepo.getAwardCategories(locale: any(named: 'locale')))
        .thenAnswer((_) async => testAwards);
    when(() => mockRepo.getKudosInfo())
        .thenAnswer((_) async => testKudosInfo);
    when(() => mockRepo.getUnreadNotificationCount())
        .thenAnswer((_) async => 3);
  }

  group('HomeViewModel', () {
    test('build() returns HomeState with all data on success', () async {
      stubAllSuccess();
      final container = createContainer();
      addTearDown(container.dispose);

      final result = await container.read(homeViewModelProvider.future);

      expect(result, isA<HomeState>());
      expect(result.eventInfo.themeName, 'Root Further');
      expect(result.awards.length, 2);
      expect(result.kudosInfo.isEnabled, true);
      expect(result.unreadNotificationCount, 3);
    });

    test('build() propagates error when any fetch fails', () async {
      when(() => mockRepo.getEventInfo(locale: any(named: 'locale')))
          .thenThrow(Exception('Network error'));
      when(() => mockRepo.getAwardCategories(locale: any(named: 'locale')))
          .thenAnswer((_) async => testAwards);
      when(() => mockRepo.getKudosInfo())
          .thenAnswer((_) async => testKudosInfo);
      when(() => mockRepo.getUnreadNotificationCount())
          .thenAnswer((_) async => 0);

      final container = createContainer();
      addTearDown(container.dispose);

      expect(
        () => container.read(homeViewModelProvider.future),
        throwsA(isA<Exception>()),
      );
    });

    test('build() returns empty awards list when no awards', () async {
      when(() => mockRepo.getEventInfo(locale: any(named: 'locale')))
          .thenAnswer((_) async => testEventInfo);
      when(() => mockRepo.getAwardCategories(locale: any(named: 'locale')))
          .thenAnswer((_) async => []);
      when(() => mockRepo.getKudosInfo())
          .thenAnswer((_) async => testKudosInfo);
      when(() => mockRepo.getUnreadNotificationCount())
          .thenAnswer((_) async => 0);

      final container = createContainer();
      addTearDown(container.dispose);

      final result = await container.read(homeViewModelProvider.future);
      expect(result.awards, isEmpty);
      expect(result.unreadNotificationCount, 0);
    });

    test('refresh() reloads all data', () async {
      stubAllSuccess();
      final container = createContainer();
      addTearDown(container.dispose);

      // Initial load
      await container.read(homeViewModelProvider.future);

      // Refresh
      await container.read(homeViewModelProvider.notifier).refresh();

      // Verify called twice (build + refresh)
      verify(() => mockRepo.getEventInfo(locale: any(named: 'locale')))
          .called(2);
      verify(() => mockRepo.getAwardCategories(locale: any(named: 'locale')))
          .called(2);
    });

    test('unread notification count = 0 when none', () async {
      when(() => mockRepo.getEventInfo(locale: any(named: 'locale')))
          .thenAnswer((_) async => testEventInfo);
      when(() => mockRepo.getAwardCategories(locale: any(named: 'locale')))
          .thenAnswer((_) async => testAwards);
      when(() => mockRepo.getKudosInfo())
          .thenAnswer((_) async => testKudosInfo);
      when(() => mockRepo.getUnreadNotificationCount())
          .thenAnswer((_) async => 0);

      final container = createContainer();
      addTearDown(container.dispose);

      final result = await container.read(homeViewModelProvider.future);
      expect(result.unreadNotificationCount, 0);
    });
  });
}

class _FakeLocaleNotifier extends StateNotifier<Locale>
    implements LocaleNotifier {
  _FakeLocaleNotifier() : super(const Locale('vi'));

  @override
  void changeLocale(String code) => state = Locale(code);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
