import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/core/constants/app_constants.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(this._prefs) : super(const Locale('vi')) {
    _loadSavedLocale();
  }

  final SharedPreferences _prefs;

  void _loadSavedLocale() {
    final saved = _prefs.getString('locale');
    if (saved != null && AppConstants.supportedLocaleCodes.contains(saved)) {
      state = Locale(saved);
    }
  }

  void changeLocale(String code) {
    if (!AppConstants.supportedLocaleCodes.contains(code)) {
      code = AppConstants.defaultLocaleCode;
    }
    state = Locale(code);
    _prefs.setString('locale', code);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

final localeNotifierProvider = StateNotifierProvider<LocaleNotifier, Locale>((
  ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocaleNotifier(prefs);
});
