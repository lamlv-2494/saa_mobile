import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/all_kudos_page_view.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_card.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

import '../../helpers/kudos_test_helpers.dart';

/// Kudos list with empty avatar URLs so no network requests are made in tests.
List<Kudos> buildWidgetTestKudosList({int count = 5}) => List.generate(
      count,
      (i) => createKudos(
        id: 'wtest-$i',
        sender: createUserSummary(id: 'sender-$i', avatar: ''),
        receiver: createUserSummary(id: 'receiver-$i', avatar: ''),
        imageUrls: [],
      ),
    );

Widget buildAllKudosPageView({
  List<Kudos>? kudosList,
  bool hasMore = true,
  bool isLoadingMore = false,
  bool hasLoadError = false,
  VoidCallback? onBackToFeed,
  VoidCallback? onLoadMore,
  Future<void> Function()? onRefresh,
  void Function(String)? onHeartTap,
  void Function(String)? onAvatarTap,
  VoidCallback? onRetry,
}) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(
        body: AllKudosPageView(
          kudosList: kudosList ?? [],
          hasMore: hasMore,
          isLoadingMore: isLoadingMore,
          hasLoadError: hasLoadError,
          onBackToFeed: onBackToFeed ?? () {},
          onLoadMore: onLoadMore ?? () {},
          onRefresh: onRefresh ?? () async {},
          onHeartTap: onHeartTap ?? (_) {},
          onAvatarTap: onAvatarTap ?? (_) {},
          formatTimeAgo: (_) => '1 day ago',
          onRetry: onRetry,
        ),
      ),
    ),
  );
}

void main() {
  // ──────────────────────────────────────────────────
  // T021: AllKudosPageView render tests
  // ──────────────────────────────────────────────────
  group('AllKudosPageView - rendering (T021)', () {
    testWidgets('hiển thị header "ALL KUDOS"', (tester) async {
      await tester.pumpWidget(
        buildAllKudosPageView(kudosList: buildWidgetTestKudosList(count: 3)),
      );
      await tester.pump();

      expect(find.text(t.kudos.allKudosTitle), findsOneWidget);
    });

    testWidgets('hiển thị navbar title "All Kudos"', (tester) async {
      await tester.pumpWidget(
        buildAllKudosPageView(kudosList: buildWidgetTestKudosList(count: 3)),
      );
      await tester.pump();

      expect(find.text(t.kudos.allKudosNavbarTitle), findsOneWidget);
    });

    testWidgets('hiển thị KudosCard cho mỗi kudos trong list', (tester) async {
      // Use buildWidgetTestKudosList (empty avatars, no network) with count: 2
      // SliverList only builds visible items; 2 cards fit in the test viewport.
      final kudosList = buildWidgetTestKudosList(count: 2);
      await tester.pumpWidget(buildAllKudosPageView(kudosList: kudosList));
      await tester.pump();

      expect(find.byType(KudosCard), findsNWidgets(2));
    });

    testWidgets('back button (Key allKudosBackButton) có mặt', (tester) async {
      await tester.pumpWidget(
        buildAllKudosPageView(kudosList: buildWidgetTestKudosList(count: 2)),
      );
      await tester.pump();

      expect(find.byKey(const Key('allKudosBackButton')), findsOneWidget);
    });

    testWidgets('back button gọi onBackToFeed khi tap', (tester) async {
      var called = false;
      await tester.pumpWidget(
        buildAllKudosPageView(
          kudosList: buildWidgetTestKudosList(count: 2),
          onBackToFeed: () => called = true,
        ),
      );
      await tester.pump();

      await tester.tap(find.byKey(const Key('allKudosBackButton')));
      expect(called, isTrue);
    });

    testWidgets('hiển thị empty state khi kudosList rỗng và không loading',
        (tester) async {
      await tester.pumpWidget(
        buildAllKudosPageView(kudosList: [], isLoadingMore: false),
      );
      await tester.pump();

      expect(find.text(t.kudos.allKudosEmpty), findsOneWidget);
      expect(find.byType(KudosCard), findsNothing);
    });

    testWidgets(
        'hiển thị loading indicator ở cuối list khi isLoadingMore = true',
        (tester) async {
      // Use empty list so loading indicator renders at top (no scrolling needed
      // to bring it into viewport)
      await tester.pumpWidget(
        buildAllKudosPageView(
          kudosList: [],
          isLoadingMore: true,
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('không hiển thị loading indicator khi isLoadingMore = false',
        (tester) async {
      await tester.pumpWidget(
        buildAllKudosPageView(
          kudosList: buildWidgetTestKudosList(count: 3),
          isLoadingMore: false,
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('hiển thị error state khi hasLoadError = true và list rỗng',
        (tester) async {
      await tester.pumpWidget(
        buildAllKudosPageView(kudosList: [], hasLoadError: true),
      );
      await tester.pump();

      expect(
        find.text(t.kudos.allKudosLoadError),
        findsOneWidget,
      );
    });

    testWidgets('hiển thị nút Retry trong error state', (tester) async {
      var retryCalled = false;
      await tester.pumpWidget(
        buildAllKudosPageView(
          kudosList: [],
          hasLoadError: true,
          onRetry: () => retryCalled = true,
        ),
      );
      await tester.pump();

      expect(find.text(t.kudos.allKudosRetry), findsOneWidget);
      await tester.tap(find.text(t.kudos.allKudosRetry));
      expect(retryCalled, isTrue);
    });
  });

  // ──────────────────────────────────────────────────
  // T022: Infinite scroll — onLoadMore callback
  // ──────────────────────────────────────────────────
  group('AllKudosPageView - infinite scroll (T022)', () {
    testWidgets(
        'gọi onLoadMore khi scroll gần cuối (pixels >= maxScrollExtent - 200)',
        (tester) async {
      var loadMoreCalled = false;

      // Create a long enough list so the list is scrollable
      final kudosList = buildWidgetTestKudosList(count: 20);

      await tester.pumpWidget(
        buildAllKudosPageView(
          kudosList: kudosList,
          hasMore: true,
          isLoadingMore: false,
          onLoadMore: () => loadMoreCalled = true,
        ),
      );
      await tester.pump();

      // Scroll to the bottom
      await tester.drag(
        find.byType(CustomScrollView),
        const Offset(0, -5000),
      );
      await tester.pump();

      expect(loadMoreCalled, isTrue);
    });

    testWidgets('không gọi onLoadMore khi isLoadingMore = true', (tester) async {
      var loadMoreCalled = false;
      final kudosList = buildWidgetTestKudosList(count: 20);

      await tester.pumpWidget(
        buildAllKudosPageView(
          kudosList: kudosList,
          hasMore: true,
          isLoadingMore: true,
          onLoadMore: () => loadMoreCalled = true,
        ),
      );
      await tester.pump();

      await tester.drag(
        find.byType(CustomScrollView),
        const Offset(0, -5000),
      );
      await tester.pump();

      expect(loadMoreCalled, isFalse);
    });

    testWidgets('không gọi onLoadMore khi hasMore = false', (tester) async {
      var loadMoreCalled = false;
      final kudosList = buildWidgetTestKudosList(count: 20);

      await tester.pumpWidget(
        buildAllKudosPageView(
          kudosList: kudosList,
          hasMore: false,
          isLoadingMore: false,
          onLoadMore: () => loadMoreCalled = true,
        ),
      );
      await tester.pump();

      await tester.drag(
        find.byType(CustomScrollView),
        const Offset(0, -5000),
      );
      await tester.pump();

      expect(loadMoreCalled, isFalse);
    });
  });

  // ──────────────────────────────────────────────────
  // T023: Pull-to-refresh
  // ──────────────────────────────────────────────────
  group('AllKudosPageView - pull to refresh (T023)', () {
    testWidgets('RefreshIndicator có mặt trong widget tree', (tester) async {
      await tester.pumpWidget(
        buildAllKudosPageView(kudosList: buildWidgetTestKudosList(count: 3)),
      );
      await tester.pump();

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('kéo xuống trigger onRefresh callback', (tester) async {
      var refreshCalled = false;
      await tester.pumpWidget(
        buildAllKudosPageView(
          kudosList: buildWidgetTestKudosList(count: 3),
          onRefresh: () async => refreshCalled = true,
        ),
      );
      await tester.pump();

      // Perform pull-to-refresh gesture
      await tester.fling(
        find.byType(CustomScrollView),
        const Offset(0, 300),
        1000,
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(refreshCalled, isTrue);
    });
  });
}
