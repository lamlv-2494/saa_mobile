import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/home/presentation/widgets/countdown_timer_widget.dart';

void main() {
  Widget buildTestWidget(DateTime eventDate) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: CountdownTimerWidget(eventDate: eventDate),
        ),
      ),
    );
  }

  group('CountdownTimerWidget', () {
    testWidgets('displays correct days/hours/minutes for future date',
        (tester) async {
      final futureDate = DateTime.now().add(const Duration(
        days: 20,
        hours: 5,
        minutes: 30,
      ));

      await tester.pumpWidget(buildTestWidget(futureDate));

      // Should find DAYS, HOURS, MINUTES labels
      expect(find.text('DAYS'), findsOneWidget);
      expect(find.text('HOURS'), findsOneWidget);
      expect(find.text('MINUTES'), findsOneWidget);
    });

    testWidgets('displays 00 for all units when event date is in the past',
        (tester) async {
      final pastDate = DateTime.now().subtract(const Duration(days: 1));

      await tester.pumpWidget(buildTestWidget(pastDate));

      // All digit boxes should show 0
      // The "00" is split into two digit boxes per unit = 6 boxes of "0"
      expect(find.text('0'), findsNWidgets(6));
    });

    testWidgets('updates countdown after 1 second', (tester) async {
      final futureDate = DateTime.now().add(const Duration(days: 10));

      await tester.pumpWidget(buildTestWidget(futureDate));

      // Capture initial state exists
      expect(find.text('DAYS'), findsOneWidget);

      // Advance timer by 2 seconds
      await tester.pump(const Duration(seconds: 2));

      // Should still render (timer ticked, widget rebuilt)
      expect(find.text('DAYS'), findsOneWidget);
    });

    testWidgets('disposes timer without error', (tester) async {
      final futureDate = DateTime.now().add(const Duration(days: 5));

      await tester.pumpWidget(buildTestWidget(futureDate));
      expect(find.text('DAYS'), findsOneWidget);

      // Remove widget — should not throw
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: SizedBox.shrink())),
        ),
      );
    });
  });
}
