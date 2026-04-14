import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/features/award/data/models/award_prize.dart';
import 'package:saa_mobile/features/award/data/models/award_state.dart';
import 'package:saa_mobile/features/award/data/repositories/award_repository.dart';
import 'package:saa_mobile/features/award/presentation/viewmodels/award_viewmodel.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

class MockAwardRepository extends Mock implements AwardRepository {}

class _FakeLocaleNotifier extends StateNotifier<Locale>
    implements LocaleNotifier {
  _FakeLocaleNotifier() : super(const Locale('vi'));

  @override
  void changeLocale(String code) => state = Locale(code);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockAwardRepository mockRepo;

  final testCategories = [
    const AwardCategory(
      id: 1,
      name: 'Top Talent',
      slug: 'top-talent',
      description: 'Top Talent desc',
      quantity: 10,
      unit: 'Cá nhân',
      prizeValue: 7000000,
      prizeNote: 'cho mỗi giải thưởng',
      sortOrder: 1,
    ),
    const AwardCategory(
      id: 2,
      name: 'Top Project',
      slug: 'top-project',
      description: 'Top Project desc',
      quantity: 2,
      unit: 'Tập thể',
      prizeValue: 15000000,
      prizeNote: 'cho mỗi giải thưởng',
      sortOrder: 2,
    ),
    const AwardCategory(
      id: 3,
      name: 'Top Project Leader',
      slug: 'top-project-leader',
      description: 'Top Project Leader desc',
      quantity: 3,
      unit: 'Cá nhân',
      prizeValue: 7000000,
      prizeNote: 'cho mỗi giải thưởng',
      sortOrder: 3,
    ),
    const AwardCategory(
      id: 4,
      name: 'Best Manager',
      slug: 'best-manager',
      description: 'Best Manager desc',
      quantity: 1,
      unit: 'Cá nhân',
      prizeValue: 10000000,
      prizeNote: 'cho mỗi giải thưởng',
      sortOrder: 4,
    ),
    const AwardCategory(
      id: 5,
      name: 'Signature 2025 - Creator',
      slug: 'signature-2025-creator',
      description: 'Signature desc',
      quantity: 1,
      unit: 'Cá nhân hoặc tập thể',
      sortOrder: 5,
      awardPrizes: [
        AwardPrize(
          id: 1,
          awardCategoryId: 5,
          prizeType: 'individual',
          valueAmount: 5000000,
          noteVi: 'cho giải cá nhân',
          noteEn: 'for individual award',
        ),
        AwardPrize(
          id: 2,
          awardCategoryId: 5,
          prizeType: 'team',
          valueAmount: 8000000,
          noteVi: 'cho giải tập thể',
          noteEn: 'for team award',
        ),
      ],
    ),
    const AwardCategory(
      id: 6,
      name: 'MVP',
      slug: 'mvp',
      description: 'MVP desc',
      quantity: 1,
      unit: 'Cá nhân',
      prizeValue: 15000000,
      prizeNote: 'cho giải cá nhân',
      sortOrder: 6,
    ),
  ];

  setUp(() {
    mockRepo = MockAwardRepository();
  });

  ProviderContainer createContainer() {
    SharedPreferences.setMockInitialValues({});
    return ProviderContainer(
      overrides: [
        awardRepositoryProvider.overrideWithValue(mockRepo),
        localeNotifierProvider.overrideWith((ref) => _FakeLocaleNotifier()),
      ],
    );
  }

  group('AwardViewModel', () {
    test(
      'build() fetches 6 categories and defaults selectedIndex to 0',
      () async {
        when(
          () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
        ).thenAnswer((_) async => testCategories);

        final container = createContainer();
        addTearDown(container.dispose);

        final result = await container.read(awardViewModelProvider.future);

        expect(result, isA<AwardState>());
        expect(result.categories.length, 6);
        expect(result.selectedIndex, 0);
        expect(result.selectedCategory?.name, 'Top Talent');
      },
    );

    test('selectCategory() changes selectedIndex', () async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      final container = createContainer();
      addTearDown(container.dispose);

      await container.read(awardViewModelProvider.future);

      container.read(awardViewModelProvider.notifier).selectCategory(3);

      final result = container.read(awardViewModelProvider).valueOrNull;
      expect(result?.selectedIndex, 3);
      expect(result?.selectedCategory?.name, 'Best Manager');
    });

    test('selectCategory() ignores out-of-range index', () async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      final container = createContainer();
      addTearDown(container.dispose);

      await container.read(awardViewModelProvider.future);

      container.read(awardViewModelProvider.notifier).selectCategory(10);

      final result = container.read(awardViewModelProvider).valueOrNull;
      expect(result?.selectedIndex, 0);
    });

    test('selectBySlug() finds correct index', () async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      final container = createContainer();
      addTearDown(container.dispose);

      await container.read(awardViewModelProvider.future);

      container
          .read(awardViewModelProvider.notifier)
          .selectBySlug('top-project');

      final result = container.read(awardViewModelProvider).valueOrNull;
      expect(result?.selectedIndex, 1);
      expect(result?.selectedCategory?.name, 'Top Project');
    });

    test('selectBySlug() does nothing for unknown slug', () async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      final container = createContainer();
      addTearDown(container.dispose);

      await container.read(awardViewModelProvider.future);

      container
          .read(awardViewModelProvider.notifier)
          .selectBySlug('nonexistent');

      final result = container.read(awardViewModelProvider).valueOrNull;
      expect(result?.selectedIndex, 0);
    });

    test('build() propagates error on fetch failure', () async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenThrow(Exception('Network error'));

      final container = createContainer();
      addTearDown(container.dispose);

      expect(
        () => container.read(awardViewModelProvider.future),
        throwsA(isA<Exception>()),
      );
    });

    test('refresh() reloads all data', () async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      final container = createContainer();
      addTearDown(container.dispose);

      await container.read(awardViewModelProvider.future);
      await container.read(awardViewModelProvider.notifier).refresh();

      verify(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).called(2);
    });

    test('selectedCategory is null when categories empty', () {
      const emptyState = AwardState();
      expect(emptyState.selectedCategory, isNull);
    });

    test('Signature category has multiple award prizes', () async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      final container = createContainer();
      addTearDown(container.dispose);

      await container.read(awardViewModelProvider.future);

      container.read(awardViewModelProvider.notifier).selectCategory(4);
      final state = container.read(awardViewModelProvider).valueOrNull;

      expect(state?.selectedCategory?.name, 'Signature 2025 - Creator');
      expect(state?.selectedCategory?.prizeValue, isNull);
      expect(state?.selectedCategory?.awardPrizes.length, 2);
    });
  });
}
