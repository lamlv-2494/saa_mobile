import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/shared/widgets/outline_button.dart';

void main() {
  Widget buildTestWidget({
    String label = 'Test',
    VoidCallback? onPressed,
    SvgPicture? icon,
    double? width,
    double height = 40,
    bool enabled = true,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: OutlineButtonWidget(
            label: label,
            onPressed: onPressed ?? () {},
            icon: icon,
            width: width,
            height: height,
            enabled: enabled,
          ),
        ),
      ),
    );
  }

  group('OutlineButtonWidget', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(buildTestWidget(label: 'About Kudos'));

      expect(find.text('About Kudos'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestWidget(onPressed: () => tapped = true),
      );

      await tester.tap(find.byType(OutlineButtonWidget));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestWidget(onPressed: () => tapped = true, enabled: false),
      );

      await tester.tap(find.byType(OutlineButtonWidget));
      expect(tapped, isFalse);
    });

    testWidgets('renders SvgPicture icon when provided', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          icon: SvgPicture.asset(
            'assets/icons/ic_arrow_open.svg',
            width: 16,
            height: 16,
          ),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('does not render icon when null', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(SvgPicture), findsNothing);
    });

    testWidgets('uses min width when width is null', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('uses max width when width is provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(width: 200));

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisSize, MainAxisSize.max);
    });
  });
}
