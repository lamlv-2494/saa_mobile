import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/home/data/repositories/countdown_repository.dart';
import 'package:saa_mobile/features/home/presentation/widgets/countdown_digit_box.dart';
import 'package:saa_mobile/features/home/presentation/widgets/countdown_timer_widget.dart';

class _FakeCountdownRepository implements CountdownRepository {
  _FakeCountdownRepository({
    required this.initialEndTime,
    required this.resetValue,
  });

  DateTime initialEndTime;
  DateTime resetValue;

  int getOrInitCalls = 0;
  int resetCalls = 0;
  int clearCalls = 0;

  @override
  Future<DateTime> getOrInitEndTime() async {
    getOrInitCalls++;
    return initialEndTime;
  }

  @override
  Future<DateTime> resetEndTime() async {
    resetCalls++;
    initialEndTime = resetValue;
    return resetValue;
  }

  @override
  Future<void> clear() async {
    clearCalls++;
  }
}

String _digitOf(WidgetTester tester, Finder finder) {
  final widget = tester.widget<CountdownDigitBox>(finder);
  return widget.digit;
}

/// Returns digits [d0, d1, h0, h1, m0, m1] from the widget tree.
List<String> _readDigits(WidgetTester tester) {
  final boxes = find.byType(CountdownDigitBox);
  expect(boxes, findsNWidgets(6));
  return List.generate(6, (i) => _digitOf(tester, boxes.at(i)));
}

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  final fixedNow = DateTime.utc(2026, 4, 17, 10, 0, 0);

  group('CountdownTimerWidget (v2)', () {
    testWidgets('(a) renders DD/HH/MM from repo endTime using nowBuilder', (
      tester,
    ) async {
      final repo = _FakeCountdownRepository(
        initialEndTime: fixedNow.add(
          const Duration(days: 5, hours: 0, minutes: 0),
        ),
        resetValue: fixedNow.add(const Duration(days: 20)),
      );

      await tester.pumpWidget(
        _wrap(
          CountdownTimerWidget(repository: repo, nowBuilder: () => fixedNow),
        ),
      );

      // Allow async initState to resolve.
      await tester.pump();

      expect(_readDigits(tester), ['0', '5', '0', '0', '0', '0']);
      expect(find.text('DAYS'), findsOneWidget);
      expect(find.text('HOURS'), findsOneWidget);
      expect(find.text('MINUTES'), findsOneWidget);
      expect(repo.getOrInitCalls, 1);
      expect(repo.resetCalls, 0);
    });

    testWidgets('(b) auto-resets when stored endTime is already <= now', (
      tester,
    ) async {
      final repo = _FakeCountdownRepository(
        initialEndTime: fixedNow.subtract(const Duration(seconds: 1)),
        resetValue: fixedNow.add(const Duration(days: 20)),
      );

      await tester.pumpWidget(
        _wrap(
          CountdownTimerWidget(repository: repo, nowBuilder: () => fixedNow),
        ),
      );

      // initState async + reset async need to flush.
      await tester.pump();
      await tester.pump();

      expect(repo.resetCalls, 1);
      expect(_readDigits(tester), ['2', '0', '0', '0', '0', '0']);
    });

    testWidgets(
      '(c) clock tampered backwards — countdown increases without reset',
      (tester) async {
        final repo = _FakeCountdownRepository(
          initialEndTime: fixedNow.add(const Duration(days: 10)),
          resetValue: fixedNow.add(const Duration(days: 20)),
        );

        // Simulate user rewinding device clock by 2 days.
        await tester.pumpWidget(
          _wrap(
            CountdownTimerWidget(
              repository: repo,
              nowBuilder: () => fixedNow.subtract(const Duration(days: 2)),
            ),
          ),
        );

        await tester.pump();

        // 10 days until endTime, but "now" is 2 days earlier → 12 days.
        expect(_readDigits(tester), ['1', '2', '0', '0', '0', '0']);
        expect(repo.resetCalls, 0);
      },
    );

    testWidgets('(d) dispose cancels timer without exception', (tester) async {
      final repo = _FakeCountdownRepository(
        initialEndTime: fixedNow.add(const Duration(days: 5)),
        resetValue: fixedNow.add(const Duration(days: 20)),
      );

      await tester.pumpWidget(
        _wrap(
          CountdownTimerWidget(repository: repo, nowBuilder: () => fixedNow),
        ),
      );
      await tester.pump();

      // Remove widget.
      await tester.pumpWidget(_wrap(const SizedBox.shrink()));

      // Advance time — timer must be cancelled, otherwise pump throws.
      await tester.pump(const Duration(seconds: 2));
    });
  });
}
