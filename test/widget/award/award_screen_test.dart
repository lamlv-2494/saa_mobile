import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/features/award/data/models/award_prize.dart';
import 'package:saa_mobile/features/award/data/repositories/award_repository.dart';
import 'package:saa_mobile/features/award/presentation/screens/award_screen.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_dropdown_filter.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_info_block_widget.dart';
import 'package:saa_mobile/features/award/presentation/widgets/kv_kudos_banner_widget.dart';
import 'package:saa_mobile/features/award/presentation/widgets/sun_kudos_block_widget.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

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
      imageUrl: '/storage/v1/object/public/badges/top_talent.png',
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
      imageUrl: '/storage/v1/object/public/badges/top_project.png',
      quantity: 2,
      unit: 'Tập thể',
      prizeValue: 15000000,
      prizeNote: 'cho mỗi giải thưởng',
      sortOrder: 2,
    ),
    const AwardCategory(
      id: 5,
      name: 'Signature 2025 - Creator',
      slug: 'signature-2025-creator',
      description: 'Signature desc',
      imageUrl: '/storage/v1/object/public/badges/signature.png',
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
  ];

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  setUp(() {
    mockRepo = MockAwardRepository();
  });

  Widget buildTestWidget() {
    SharedPreferences.setMockInitialValues({});
    return ProviderScope(
      overrides: [
        awardRepositoryProvider.overrideWithValue(mockRepo),
        localeNotifierProvider.overrideWith((ref) => _FakeLocaleNotifier()),
      ],
      child: const MaterialApp(home: AwardScreen()),
    );
  }

  group('AwardScreen', () {
    testWidgets('renders full layout on success', (tester) async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // KV Banner
      expect(find.byType(KvKudosBanner), findsOneWidget);
      // Section header
      expect(find.byType(SectionHeaderWidget), findsAtLeast(1));
      // Dropdown
      expect(find.byType(AwardDropdownFilter), findsOneWidget);
      // Award info block
      expect(find.byType(AwardInfoBlock), findsOneWidget);
    });

    testWidgets('shows loading state initially', (tester) async {
      final completer = Completer<List<AwardCategory>>();
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) => completer.future);

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Should show shimmer/loading content (no AwardInfoBlock yet)
      expect(find.byType(AwardInfoBlock), findsNothing);

      // Complete to avoid pending timers
      completer.complete(testCategories);
      await tester.pumpAndSettle();
    });

    testWidgets('shows error state with retry button', (tester) async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenThrow(Exception('Network error'));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Error state should show retry text
      expect(find.textContaining('lỗi'), findsOneWidget);
    });

    testWidgets('defaults to first category (Top Talent)', (tester) async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Top Talent'), findsAtLeast(1));
      expect(find.text('Top Talent desc'), findsOneWidget);
    });

    testWidgets('Sun* Kudos block is present', (tester) async {
      when(
        () => mockRepo.getCategoriesWithPrizes(locale: any(named: 'locale')),
      ).thenAnswer((_) async => testCategories);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SunKudosBlock), findsOneWidget);
    });
  });
}
