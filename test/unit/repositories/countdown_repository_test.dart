import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/features/home/data/repositories/countdown_repository.dart';

void main() {
  const storageKey = 'home_countdown_end_time';
  const period = Duration(days: 20);

  late SharedPreferences prefs;
  late DateTime fixedNow;
  late CountdownRepositoryImpl repo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    fixedNow = DateTime.utc(2026, 4, 17, 10, 0, 0);
    repo = CountdownRepositoryImpl(prefs, now: () => fixedNow);
  });

  group('CountdownRepository.getOrInitEndTime', () {
    test(
      '(a) initialises now + 20d and persists when storage is empty',
      () async {
        final result = await repo.getOrInitEndTime();

        expect(result, fixedNow.add(period));
        expect(
          prefs.getString(storageKey),
          fixedNow.add(period).toIso8601String(),
        );
      },
    );

    test('(b) re-initialises when stored value cannot be parsed', () async {
      SharedPreferences.setMockInitialValues({storageKey: 'not-a-date'});
      prefs = await SharedPreferences.getInstance();
      repo = CountdownRepositoryImpl(prefs, now: () => fixedNow);

      final result = await repo.getOrInitEndTime();

      expect(result, fixedNow.add(period));
      expect(
        prefs.getString(storageKey),
        fixedNow.add(period).toIso8601String(),
      );
    });

    test('(c) returns stored ISO-8601 value unchanged when valid', () async {
      final stored = DateTime.utc(2026, 5, 1, 8, 30).toIso8601String();
      SharedPreferences.setMockInitialValues({storageKey: stored});
      prefs = await SharedPreferences.getInstance();
      repo = CountdownRepositoryImpl(prefs, now: () => fixedNow);

      final result = await repo.getOrInitEndTime();

      expect(result, DateTime.parse(stored));
      expect(prefs.getString(storageKey), stored);
    });
  });

  group('CountdownRepository.resetEndTime', () {
    test(
      '(d) overwrites storage with now + 20d and returns the value',
      () async {
        SharedPreferences.setMockInitialValues({
          storageKey: DateTime.utc(2024, 1, 1).toIso8601String(),
        });
        prefs = await SharedPreferences.getInstance();
        repo = CountdownRepositoryImpl(prefs, now: () => fixedNow);

        final result = await repo.resetEndTime();

        expect(result, fixedNow.add(period));
        expect(
          prefs.getString(storageKey),
          fixedNow.add(period).toIso8601String(),
        );
      },
    );
  });

  group('CountdownRepository.clear', () {
    test('(e) removes the stored end time key', () async {
      SharedPreferences.setMockInitialValues({
        storageKey: fixedNow.toIso8601String(),
      });
      prefs = await SharedPreferences.getInstance();
      repo = CountdownRepositoryImpl(prefs, now: () => fixedNow);

      await repo.clear();

      expect(prefs.getString(storageKey), isNull);
    });
  });
}
