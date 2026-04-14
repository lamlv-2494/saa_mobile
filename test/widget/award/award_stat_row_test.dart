import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/award/presentation/widgets/award_stat_row_widget.dart';

void main() {
  Widget buildTestWidget({double valueUnitGap = 4}) {
    return MaterialApp(
      home: Scaffold(
        body: AwardStatRow(
          icon: SvgPicture.asset(
            'assets/icons/ic_diamond.svg',
            width: 24,
            height: 24,
          ),
          label: 'Số lượng giải thưởng',
          value: '10',
          unit: 'Cá nhân',
          valueUnitGap: valueUnitGap,
        ),
      ),
    );
  }

  group('AwardStatRow', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Số lượng giải thưởng'), findsOneWidget);
    });

    testWidgets('renders value and unit text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('10'), findsOneWidget);
      expect(find.text('Cá nhân'), findsOneWidget);
    });

    testWidgets('renders icon', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('uses 4px gap for quantity stat', (tester) async {
      await tester.pumpWidget(buildTestWidget(valueUnitGap: 4));
      await tester.pump();

      // Find the SizedBox between value and unit
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final gapBox = sizedBoxes.where((s) => s.width == 4).toList();
      expect(gapBox, isNotEmpty);
    });

    testWidgets('uses 8px gap for prize stat', (tester) async {
      await tester.pumpWidget(buildTestWidget(valueUnitGap: 8));
      await tester.pump();

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final gapBox = sizedBoxes.where((s) => s.width == 8).toList();
      expect(gapBox, isNotEmpty);
    });
  });
}
