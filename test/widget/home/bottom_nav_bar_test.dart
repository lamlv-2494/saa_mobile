import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/shared/widgets/bottom_nav_bar.dart';

void main() {
  Widget buildTestWidget({
    int currentIndex = 0,
    ValueChanged<int>? onTap,
  }) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNavBar(
            currentIndex: currentIndex,
            onTap: onTap ?? (_) {},
          ),
        ),
      ),
    );
  }

  group('BottomNavBar', () {
    testWidgets('renders 4 tab labels', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('SAA 2025'), findsOneWidget);
      expect(find.text('Awards'), findsOneWidget);
      expect(find.text('Kudos'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('calls onTap with correct index when tab is tapped',
        (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        buildTestWidget(onTap: (index) => tappedIndex = index),
      );

      await tester.tap(find.text('Awards'));
      expect(tappedIndex, 1);

      await tester.tap(find.text('Kudos'));
      expect(tappedIndex, 2);

      await tester.tap(find.text('Profile'));
      expect(tappedIndex, 3);
    });

    testWidgets('initial tab is highlighted', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0));

      // SAA 2025 tab should have accent color text
      final saaText = tester.widget<Text>(find.text('SAA 2025'));
      expect(
        (saaText.style?.color?.toARGB32()),
        equals(const Color(0xFFFFEA9E).toARGB32()),
      );

      // Awards tab should have white text
      final awardsText = tester.widget<Text>(find.text('Awards'));
      expect(
        (awardsText.style?.color?.toARGB32()),
        equals(const Color(0xFFFFFFFF).toARGB32()),
      );
    });

    testWidgets('changing currentIndex highlights correct tab',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 2));

      // Kudos tab should have accent color
      final kudosText = tester.widget<Text>(find.text('Kudos'));
      expect(
        (kudosText.style?.color?.toARGB32()),
        equals(const Color(0xFFFFEA9E).toARGB32()),
      );

      // SAA 2025 tab should be inactive (white)
      final saaText = tester.widget<Text>(find.text('SAA 2025'));
      expect(
        (saaText.style?.color?.toARGB32()),
        equals(const Color(0xFFFFFFFF).toARGB32()),
      );
    });
  });
}
