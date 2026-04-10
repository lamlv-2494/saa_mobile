/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 20 (10 per locale)
///
/// Built on 2026-04-09 at 12:33 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.vi;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.vi) // set locale
/// - Locale locale = AppLocale.vi.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.vi) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	vi(languageCode: 'vi', build: Translations.build),
	en(languageCode: 'en', build: _StringsEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsLoginVi login = _StringsLoginVi._(_root);
	late final _StringsLanguageVi language = _StringsLanguageVi._(_root);
	late final _StringsErrorVi error = _StringsErrorVi._(_root);
	late final _StringsAccessibilityVi accessibility = _StringsAccessibilityVi._(_root);
}

// Path: login
class _StringsLoginVi {
	_StringsLoginVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get description => 'Bắt đầu hành trình của bạn cùng SAA 2025.\nĐăng nhập để khám phá!';
	String get button => 'LOGIN With Google';
	String get copyright => 'Bản quyền thuộc về Sun* © 2025';
}

// Path: language
class _StringsLanguageVi {
	_StringsLanguageVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get vi => 'VN';
	String get en => 'EN';
	String get selectorLabel => 'Chọn ngôn ngữ';
}

// Path: error
class _StringsErrorVi {
	_StringsErrorVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get network => 'Không có kết nối mạng. Vui lòng thử lại.';
	String get auth => 'Đăng nhập thất bại. Vui lòng thử lại.';
}

// Path: accessibility
class _StringsAccessibilityVi {
	_StringsAccessibilityVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loginButton => 'Đăng nhập bằng Google';
	String get languageSelector => 'Chọn ngôn ngữ, hiện tại: Tiếng Việt';
}

// Path: <root>
class _StringsEn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsLoginEn login = _StringsLoginEn._(_root);
	@override late final _StringsLanguageEn language = _StringsLanguageEn._(_root);
	@override late final _StringsErrorEn error = _StringsErrorEn._(_root);
	@override late final _StringsAccessibilityEn accessibility = _StringsAccessibilityEn._(_root);
}

// Path: login
class _StringsLoginEn implements _StringsLoginVi {
	_StringsLoginEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'Start your journey with SAA 2025.\nLog in to explore!';
	@override String get button => 'LOGIN With Google';
	@override String get copyright => 'Copyright belongs to Sun* © 2025';
}

// Path: language
class _StringsLanguageEn implements _StringsLanguageVi {
	_StringsLanguageEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get vi => 'VN';
	@override String get en => 'EN';
	@override String get selectorLabel => 'Select language';
}

// Path: error
class _StringsErrorEn implements _StringsErrorVi {
	_StringsErrorEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get network => 'No internet connection. Please try again.';
	@override String get auth => 'Login failed. Please try again.';
}

// Path: accessibility
class _StringsAccessibilityEn implements _StringsAccessibilityVi {
	_StringsAccessibilityEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get loginButton => 'Sign in with Google';
	@override String get languageSelector => 'Select language, currently: English';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'login.description': return 'Bắt đầu hành trình của bạn cùng SAA 2025.\nĐăng nhập để khám phá!';
			case 'login.button': return 'LOGIN With Google';
			case 'login.copyright': return 'Bản quyền thuộc về Sun* © 2025';
			case 'language.vi': return 'VN';
			case 'language.en': return 'EN';
			case 'language.selectorLabel': return 'Chọn ngôn ngữ';
			case 'error.network': return 'Không có kết nối mạng. Vui lòng thử lại.';
			case 'error.auth': return 'Đăng nhập thất bại. Vui lòng thử lại.';
			case 'accessibility.loginButton': return 'Đăng nhập bằng Google';
			case 'accessibility.languageSelector': return 'Chọn ngôn ngữ, hiện tại: Tiếng Việt';
			default: return null;
		}
	}
}

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'login.description': return 'Start your journey with SAA 2025.\nLog in to explore!';
			case 'login.button': return 'LOGIN With Google';
			case 'login.copyright': return 'Copyright belongs to Sun* © 2025';
			case 'language.vi': return 'VN';
			case 'language.en': return 'EN';
			case 'language.selectorLabel': return 'Select language';
			case 'error.network': return 'No internet connection. Please try again.';
			case 'error.auth': return 'Login failed. Please try again.';
			case 'accessibility.loginButton': return 'Sign in with Google';
			case 'accessibility.languageSelector': return 'Select language, currently: English';
			default: return null;
		}
	}
}
