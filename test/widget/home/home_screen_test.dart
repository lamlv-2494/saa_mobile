import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/features/home/data/models/event_info.dart';
import 'package:saa_mobile/features/home/data/models/kudos_info.dart';
import 'package:saa_mobile/features/home/data/repositories/home_repository.dart';
import 'package:saa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

import '../../helpers/home_mocks.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  late MockHomeRepository mockRepo;
  late SharedPreferences prefs;

  final testEventInfo = EventInfo(
    themeName: 'Root Further',
    eventDate: DateTime(2025, 12, 26, 18, 0),
    venue: 'Âu Cơ Art Center',
    livestreamNote: 'Livestream tại Facebook',
    themeDescription: 'Mô tả Root Further theme test.',
  );

  const testAwards = [
    AwardCategory(
      id: 1,
      name: 'Top Talent',
      imageUrl: '',
      description: 'Giải thưởng Top Talent',
    ),
    AwardCategory(
      id: 2,
      name: 'Top Project',
      imageUrl: '',
      description: 'Giải thưởng Top Project',
    ),
  ];

  const testKudosInfo = KudosInfo(
    bannerImageUrl: '',
    title: 'Sun* Kudos',
    description: 'Hoạt động ghi nhận đồng nghiệp.',
    isEnabled: true,
  );

  setUp(() async {
    mockRepo = MockHomeRepository();
    SharedPreferences.setMockInitialValues({'locale': 'vi'});
    prefs = await SharedPreferences.getInstance();

    when(() => mockRepo.getEventInfo(locale: any(named: 'locale')))
        .thenAnswer((_) async => testEventInfo);
    when(() => mockRepo.getAwardCategories(locale: any(named: 'locale')))
        .thenAnswer((_) async => testAwards);
    when(() => mockRepo.getKudosInfo()).thenAnswer((_) async => testKudosInfo);
    when(() => mockRepo.getUnreadNotificationCount())
        .thenAnswer((_) async => 3);
  });

  Widget buildTestWidget() {
    return ProviderScope(
      overrides: [
        homeRepositoryProvider.overrideWithValue(mockRepo),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
  }

  group('HomeScreen', () {
    testWidgets('renders hero content with event info', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Coming soon'), findsOneWidget);
      expect(find.text('DAYS'), findsOneWidget);
      expect(find.text('HOURS'), findsOneWidget);
      expect(find.text('MINUTES'), findsOneWidget);
    });

    testWidgets('renders award cards from mock data', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Top Talent'), findsWidgets);
      expect(find.text('Top Project'), findsWidgets);
    });

    testWidgets('renders notification badge when unread count > 0',
        (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Badge dot (8x8 circle with D4271D)
      final badgeFinder = find.byWidgetPredicate(
        (w) =>
            w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration as BoxDecoration).shape == BoxShape.circle &&
            (w.decoration as BoxDecoration).color?.toARGB32() ==
                const Color(0xFFD4271D).toARGB32(),
      );
      expect(badgeFinder, findsOneWidget);
    });

    testWidgets('renders FAB with write and view actions', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // FAB has "/" divider and 2 Semantics buttons
      expect(find.text('/'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == 'Write a kudos',
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == 'View Kudos',
        ),
        findsOneWidget,
      );
    });

    testWidgets('hides kudos section when isEnabled is false',
        (tester) async {
      when(() => mockRepo.getKudosInfo()).thenAnswer(
        (_) async => const KudosInfo(
          bannerImageUrl: '',
          title: 'Sun* Kudos',
          description: 'Desc',
          isEnabled: false,
        ),
      );

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Kudos section title should not appear
      expect(find.text('Sun* Kudos'), findsNothing);
    });
  });
}
