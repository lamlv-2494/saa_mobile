import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/home/presentation/widgets/kudos_fab_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

void main() {
  Widget buildTestWidget({
    VoidCallback? onWrite,
    VoidCallback? onView,
  }) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: KudosFabWidget(
            onWriteKudosTap: onWrite ?? () {},
            onViewKudosTap: onView ?? () {},
          ),
        ),
      ),
    );
  }

  group('KudosFabWidget', () {
    testWidgets('renders divider and two tap targets', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Hai nút bấm có Semantics label đúng
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == t.accessibility.fabWriteKudos,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == t.accessibility.fabViewKudos,
        ),
        findsOneWidget,
      );
      // Divider là Container 1px
      expect(
        find.byWidgetPredicate(
          (w) => w is Container && w.constraints?.maxWidth == 1,
        ),
        findsOneWidget,
      );
    });

    testWidgets('calls onWriteKudosTap when first action is tapped',
        (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(onWrite: () => tapped = true),
      );
      await tester.pumpAndSettle();

      // Tap the first Semantics (write kudos)
      final writeButton = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == t.accessibility.fabWriteKudos,
      );
      await tester.tap(writeButton);
      await tester.pump(const Duration(milliseconds: 350));
      expect(tapped, true);
    });

    testWidgets('calls onViewKudosTap when second action is tapped',
        (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(onView: () => tapped = true),
      );
      await tester.pumpAndSettle();

      final viewButton = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == t.accessibility.fabViewKudos,
      );
      await tester.tap(viewButton);
      await tester.pump(const Duration(milliseconds: 350));
      expect(tapped, true);
    });

    testWidgets('debounces rapid taps (300ms)', (tester) async {
      int tapCount = 0;
      await tester.pumpWidget(
        buildTestWidget(onWrite: () => tapCount++),
      );
      await tester.pumpAndSettle();

      final writeButton = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == t.accessibility.fabWriteKudos,
      );

      await tester.tap(writeButton);
      expect(tapCount, 1);

      await tester.tap(writeButton);
      expect(tapCount, 1); // debounced

      await tester.pump(const Duration(milliseconds: 350));
      await tester.tap(writeButton);
      expect(tapCount, 2);

      await tester.pump(const Duration(milliseconds: 350));
    });
  });
}
