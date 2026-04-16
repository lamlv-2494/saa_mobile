import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos_state.dart';
import 'package:saa_mobile/features/kudos/presentation/screens/kudos_screen.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/kudos_viewmodel.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/all_kudos_page_view.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

import '../../helpers/kudos_test_helpers.dart';

// ─── Helpers: kudos with empty avatar URLs to avoid network requests ───

List<Kudos> _testKudos({int count = 3, String prefix = 'k'}) =>
    List.generate(
      count,
      (i) => createKudos(
        id: '$prefix-$i',
        sender: createUserSummary(id: 'sender-$i', avatar: ''),
        receiver: createUserSummary(id: 'recv-$i', avatar: ''),
        imageUrls: [],
      ),
    );

// ─── Fake ViewModel ───

class _FakeKudosViewModel extends KudosViewModel {
  @override
  FutureOr<KudosState> build() async {
    // Use KudosState directly to avoid default test data with network images
    // (topGiftRecipients, spotlightData etc. default to empty/null — safe)
    return KudosState(
      highlightKudos: _testKudos(count: 2, prefix: 'h'),
      allKudos: _testKudos(count: 3, prefix: 'a'),
      allKudosPageList: _testKudos(count: 5, prefix: 'p'),
      hasMoreAllKudosPage: true,
    );
  }

  @override
  Future<void> loadAllKudosPage() async {}
}

Widget buildKudosScreen(SharedPreferences prefs) {
  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      kudosViewModelProvider.overrideWith(() => _FakeKudosViewModel()),
    ],
    child: TranslationProvider(
      child: const MaterialApp(
        home: KudosScreen(),
      ),
    ),
  );
}

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  // ──────────────────────────────────────────────────
  // T017: KudosScreen PageView tests
  // ──────────────────────────────────────────────────
  group('KudosScreen PageView (T017)', () {
    testWidgets('PageView có NeverScrollableScrollPhysics', (tester) async {
      await tester.pumpWidget(buildKudosScreen(prefs));
      await tester.pumpAndSettle();

      final pageView = tester.widget<PageView>(
        find.byKey(const Key('kudosScreenPageView')),
      );
      expect(pageView.physics, isA<NeverScrollableScrollPhysics>());
    });

    testWidgets('"View all Kudos" tap animate to page 1 (AllKudosPageView visible)',
        (tester) async {
      await tester.pumpWidget(buildKudosScreen(prefs));
      await tester.pumpAndSettle();

      // Verify page 0 is shown initially (AllKudosPageView not visible)
      expect(find.byType(AllKudosPageView), findsNothing);

      // The button is in a long scroll list. Scroll the vertical Scrollable
      // (CustomScrollView, axis: down) — not the horizontal PageView Scrollable.
      final verticalScrollable = find.byWidgetPredicate(
        (widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      );
      await tester.scrollUntilVisible(
        find.text('View all Kudos'),
        300.0,
        scrollable: verticalScrollable.first,
      );
      await tester.tap(find.text('View all Kudos'));
      await tester.pumpAndSettle();

      // Page 1 (AllKudosPageView) should now be visible
      expect(find.byType(AllKudosPageView), findsOneWidget);
    });

    testWidgets('back button on AllKudosPageView animates back to page 0',
        (tester) async {
      await tester.pumpWidget(buildKudosScreen(prefs));
      await tester.pumpAndSettle();

      // Scroll down then navigate to page 1
      final verticalScrollable = find.byWidgetPredicate(
        (widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      );
      await tester.scrollUntilVisible(
        find.text('View all Kudos'),
        300.0,
        scrollable: verticalScrollable.first,
      );
      await tester.tap(find.text('View all Kudos'));
      await tester.pumpAndSettle();

      expect(find.byType(AllKudosPageView), findsOneWidget);

      // Tap back button
      await tester.tap(find.byKey(const Key('allKudosBackButton')));
      await tester.pumpAndSettle();

      // Verify we're back on page 0: AllKudosPageView no longer visible,
      // and the KudosScreen PageView is back at page index 0.
      expect(find.byType(AllKudosPageView), findsNothing);
      final pageView = tester.widget<PageView>(
        find.byKey(const Key('kudosScreenPageView')),
      );
      expect(pageView.controller?.page?.round(), 0);
    });

    testWidgets('không thể swipe giữa 2 pages', (tester) async {
      await tester.pumpWidget(buildKudosScreen(prefs));
      await tester.pumpAndSettle();

      final pageView = tester.widget<PageView>(
        find.byKey(const Key('kudosScreenPageView')),
      );
      expect(pageView.physics, isA<NeverScrollableScrollPhysics>());
    });
  });
}
