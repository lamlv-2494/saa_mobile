import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/app/router.dart';
import 'package:saa_mobile/app/theme/app_theme.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

class App extends StatelessWidget {
  const App({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: _AppContent(),
    );
  }
}

class _AppContent extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AppContent> createState() => _AppContentState();
}

class _AppContentState extends ConsumerState<_AppContent> {
  @override
  void initState() {
    super.initState();
    // Sync slang locale with initial Riverpod locale after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeNotifierProvider);
      LocaleSettings.setLocale(_toAppLocale(locale.languageCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeNotifierProvider);

    ref.listen<Locale>(localeNotifierProvider, (previous, next) {
      LocaleSettings.setLocale(_toAppLocale(next.languageCode));
    });

    return TranslationProvider(
      child: MaterialApp.router(
        title: 'SAA Mobile',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        locale: locale,
        routerConfig: router,
      ),
    );
  }

  AppLocale _toAppLocale(String code) {
    return switch (code) {
      'en' => AppLocale.en,
      _ => AppLocale.vi,
    };
  }
}
