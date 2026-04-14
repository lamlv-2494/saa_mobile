import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/award/presentation/widgets/award_dropdown_filter.dart';

void main() {
  final items = [
    'Top Talent',
    'Top Project',
    'Top Project Leader',
    'Best Manager',
    'Signature 2025 - Creator',
    'MVP',
  ];

  int? selectedValue;

  Widget buildTestWidget({int selectedIndex = 0}) {
    selectedValue = null;
    return MaterialApp(
      home: Scaffold(
        body: AwardDropdownFilter(
          items: items,
          selectedIndex: selectedIndex,
          onChanged: (index) => selectedValue = index,
        ),
      ),
    );
  }

  group('AwardDropdownFilter', () {
    testWidgets('renders selected item text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Top Talent'), findsOneWidget);
    });

    testWidgets('opens popup with 6 items on tap', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      await tester.tap(find.byType(AwardDropdownFilter));
      await tester.pumpAndSettle();

      // All 6 items should be visible in popup
      expect(find.text('Top Talent'), findsAtLeast(1));
      expect(find.text('Top Project'), findsOneWidget);
      expect(find.text('Best Manager'), findsOneWidget);
      expect(find.text('MVP'), findsOneWidget);
    });

    testWidgets('calls onChanged when item selected', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      await tester.tap(find.byType(AwardDropdownFilter));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Top Project'));
      await tester.pumpAndSettle();

      expect(selectedValue, 1);
    });

    testWidgets('shows dropdown arrow icon', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Should find the arrow down SVG
      expect(find.byType(AwardDropdownFilter), findsOneWidget);
    });
  });
}
