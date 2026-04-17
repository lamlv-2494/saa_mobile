import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/spotlight_data.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/spotlight_section_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import '../../helpers/kudos_test_helpers.dart';

void main() {
  Widget buildTestWidget({
    SpotlightData? data,
    VoidCallback? onSearchTap,
  }) {
    return TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 375,
            child: SpotlightSectionWidget(
              data: data,
              onSearchTap: onSearchTap,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Empty State ─────────────────────────────────────────────────────────────

  group('SpotlightSectionWidget - empty state', () {
    testWidgets('hiển thị empty text khi data null', (tester) async {
      await tester.pumpWidget(buildTestWidget(data: null));
      await tester.pumpAndSettle();

      expect(find.text(t.kudos.emptySpotlight), findsOneWidget);
      expect(find.byType(InteractiveViewer), findsNothing);
    });

    testWidgets('hiển thị empty text khi entries rỗng', (tester) async {
      const emptyData = SpotlightData(entries: [], totalKudos: 0);
      await tester.pumpWidget(buildTestWidget(data: emptyData));
      await tester.pumpAndSettle();

      expect(find.text(t.kudos.emptySpotlight), findsOneWidget);
      expect(find.byType(InteractiveViewer), findsNothing);
    });
  });

  // ─── Canvas Render (entries.isNotEmpty) ───────────────────────────────────

  group('SpotlightSectionWidget - canvas render', () {
    testWidgets(
      'render InteractiveViewer khi entries không rỗng',
      (tester) async {
        final data = createSpotlightData();
        await tester.pumpWidget(buildTestWidget(data: data));
        await tester.pumpAndSettle();

        expect(find.byType(InteractiveViewer), findsOneWidget);
        // Không dùng CustomPaint
        expect(
          find.descendant(
            of: find.byType(InteractiveViewer),
            matching: find.byType(CustomPaint),
          ),
          findsNothing,
        );
      },
    );

    testWidgets(
      'hiển thị tên của từng entry trong canvas',
      (tester) async {
        final data = createSpotlightData();
        await tester.pumpWidget(buildTestWidget(data: data));
        await tester.pumpAndSettle();

        // Tên "User A" và "User B" phải xuất hiện bên trong InteractiveViewer
        expect(
          find.descendant(
            of: find.byType(InteractiveViewer),
            matching: find.text('User A'),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(InteractiveViewer),
            matching: find.text('User B'),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'không render empty text khi entries không rỗng',
      (tester) async {
        final data = createSpotlightData();
        await tester.pumpWidget(buildTestWidget(data: data));
        await tester.pumpAndSettle();

        expect(find.text(t.kudos.emptySpotlight), findsNothing);
      },
    );
  });

  // ─── KUDOS Count Label ────────────────────────────────────────────────────

  group('SpotlightSectionWidget - kudos count label', () {
    testWidgets(
      'hiển thị totalKudos count khi entries không rỗng',
      (tester) async {
        final data = createSpotlightData(totalKudos: 388);
        await tester.pumpWidget(buildTestWidget(data: data));
        await tester.pumpAndSettle();

        expect(find.textContaining('388'), findsOneWidget);
        expect(find.textContaining('KUDOS'), findsOneWidget);
      },
    );
  });

  // ─── Search Callback ─────────────────────────────────────────────────────

  group('SpotlightSectionWidget - search button', () {
    testWidgets(
      'tap search button gọi onSearchTap callback',
      (tester) async {
        bool tapped = false;
        final data = createSpotlightData();
        await tester.pumpWidget(
          buildTestWidget(
            data: data,
            onSearchTap: () => tapped = true,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key('spotlight_search_button')));
        await tester.pumpAndSettle();

        expect(tapped, isTrue);
      },
    );
  });

  // ─── Live Feed ───────────────────────────────────────────────────────────

  group('SpotlightSectionWidget - live feed', () {
    testWidgets(
      'hiển thị receiverName của recentActivity đầu tiên',
      (tester) async {
        final data = createSpotlightData(
          recentActivity: [
            const SpotlightActivity(
                timestamp: '10:00am', receiverName: 'Nguyen Van A'),
            const SpotlightActivity(
                timestamp: '09:30am', receiverName: 'Tran Thi B'),
          ],
        );
        await tester.pumpWidget(buildTestWidget(data: data));
        await tester.pumpAndSettle();

        expect(find.textContaining('Nguyen Van A'), findsOneWidget);
      },
    );

    testWidgets(
      'không hiển thị live feed khi recentActivity rỗng',
      (tester) async {
        final data = createSpotlightData(recentActivity: []);
        await tester.pumpWidget(buildTestWidget(data: data));
        await tester.pumpAndSettle();

        // Không có text chứa "am" hay "pm" khi không có activity
        expect(find.textContaining('am'), findsNothing);
        expect(find.textContaining('pm'), findsNothing);
      },
    );
  });
}
