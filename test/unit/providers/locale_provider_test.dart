import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/shared/providers/locale_provider.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
  });

  group('LocaleNotifier', () {
    test('initial locale should be vi (Vietnamese)', () {
      when(() => mockPrefs.getString('locale')).thenReturn(null);

      final notifier = LocaleNotifier(mockPrefs);

      expect(notifier.state, const Locale('vi'));
    });

    test('should load saved locale from SharedPreferences', () {
      when(() => mockPrefs.getString('locale')).thenReturn('en');

      final notifier = LocaleNotifier(mockPrefs);

      expect(notifier.state, const Locale('en'));
    });

    test('should fallback to vi for unsupported saved locale (e.g. ja)', () {
      when(() => mockPrefs.getString('locale')).thenReturn('ja');

      final notifier = LocaleNotifier(mockPrefs);

      expect(notifier.state, const Locale('vi'));
    });

    test('should fallback to vi for invalid saved locale', () {
      when(() => mockPrefs.getString('locale')).thenReturn('zz');

      final notifier = LocaleNotifier(mockPrefs);

      expect(notifier.state, const Locale('vi'));
    });

    test('changeLocale should update state and persist', () async {
      when(() => mockPrefs.getString('locale')).thenReturn(null);
      when(
        () => mockPrefs.setString('locale', 'en'),
      ).thenAnswer((_) async => true);

      final notifier = LocaleNotifier(mockPrefs);
      notifier.changeLocale('en');

      expect(notifier.state, const Locale('en'));
      verify(() => mockPrefs.setString('locale', 'en')).called(1);
    });

    test('changeLocale with unsupported code (ja) should fallback to vi', () async {
      when(() => mockPrefs.getString('locale')).thenReturn(null);
      when(
        () => mockPrefs.setString('locale', 'vi'),
      ).thenAnswer((_) async => true);

      final notifier = LocaleNotifier(mockPrefs);
      notifier.changeLocale('ja');

      expect(notifier.state, const Locale('vi'));
    });

    test('changeLocale with invalid code should fallback to vi', () async {
      when(() => mockPrefs.getString('locale')).thenReturn(null);
      when(
        () => mockPrefs.setString('locale', 'vi'),
      ).thenAnswer((_) async => true);

      final notifier = LocaleNotifier(mockPrefs);
      notifier.changeLocale('zz');

      expect(notifier.state, const Locale('vi'));
    });
  });

  group('localeNotifierProvider', () {
    test('should be accessible via ProviderContainer', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );

      final locale = container.read(localeNotifierProvider);
      expect(locale, const Locale('vi'));

      container.dispose();
    });
  });
}
