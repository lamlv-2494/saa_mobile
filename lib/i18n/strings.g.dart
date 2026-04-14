/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 160 (80 per locale)
///
/// Built on 2026-04-13 at 07:58 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	vi(languageCode: 'vi', build: _StringsVi.build);

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
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsLoginEn login = _StringsLoginEn._(_root);
	late final _StringsHomeEn home = _StringsHomeEn._(_root);
	late final _StringsNavEn nav = _StringsNavEn._(_root);
	late final _StringsLanguageEn language = _StringsLanguageEn._(_root);
	late final _StringsErrorEn error = _StringsErrorEn._(_root);
	late final _StringsKudosEn kudos = _StringsKudosEn._(_root);
	late final _StringsAccessibilityEn accessibility = _StringsAccessibilityEn._(_root);
}

// Path: login
class _StringsLoginEn {
	_StringsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get description => 'Start your journey with SAA 2025.\nLog in to explore!';
	String get button => 'LOGIN With Google';
	String get copyright => 'Copyright belongs to Sun* © 2025';
}

// Path: home
class _StringsHomeEn {
	_StringsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get comingSoon => 'Coming soon';
	String get days => 'DAYS';
	String get hours => 'HOURS';
	String get minutes => 'MINUTES';
	String get aboutAward => 'ABOUT AWARD';
	String get aboutKudos => 'ABOUT KUDOS';
	String get eventTime => 'Time:';
	String get eventVenue => 'Venue:';
	String get awardSystem => 'Award System';
	String get awardSectionLabel => 'Sun* Annual Awards 2025';
	String get details => 'Details';
	String get recognitionMovement => 'Recognition Movement';
	String get sunKudos => 'Sun* Kudos';
	String get newFeatureSaa => 'NEW IN SAA 2025';
	String get kudosDescription => 'A recognition and gratitude initiative for colleagues - held for the first time for all Sunners. Launching in November 2025, Sun* Kudos encourages Sunners to share words of recognition and gratitude through the official platform. These messages will serve as valuable input for the Heads Council during the award selection process.';
	String get awardsEmpty => 'No award data available';
	String get errorRetry => 'Something went wrong. Tap to retry.';
	String get retry => 'Retry';
}

// Path: nav
class _StringsNavEn {
	_StringsNavEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get home => 'SAA 2025';
	String get awards => 'Awards';
	String get kudos => 'Kudos';
	String get profile => 'Profile';
}

// Path: language
class _StringsLanguageEn {
	_StringsLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get vi => 'VN';
	String get en => 'EN';
	String get selectorLabel => 'Select language';
}

// Path: error
class _StringsErrorEn {
	_StringsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get network => 'No internet connection. Please try again.';
	String get auth => 'Login failed. Please try again.';
}

// Path: kudos
class _StringsKudosEn {
	_StringsKudosEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sectionLabel => 'Sun* Annual Awards 2025';
	String get tagline => 'Recognition and appreciation system';
	String get ctaText => 'Today, who do you want to send kudos to?';
	String get highlightTitle => 'HIGHLIGHT KUDOS';
	String get spotlightTitle => 'SPOTLIGHT BOARD';
	String get allKudosTitle => 'ALL KUDOS';
	String get viewAll => 'View all';
	String get viewDetail => 'View detail';
	String get copyLink => 'Copy Link';
	String get linkCopied => 'Link copied';
	String get filterHashtag => 'Hashtag';
	String get filterDepartment => 'Department';
	String get emptyHighlight => 'No Kudos available yet.';
	String get emptyFeed => 'No Kudos have been sent yet.';
	String get emptySpotlight => 'No data available.';
	String get emptyTop10 => 'No ranking data yet.';
	String get emptyFilter => 'No matching Kudos found.';
	String get errorRetry => 'Something went wrong. Tap to retry.';
	String get retry => 'Retry';
	String get statsKudosReceived => 'Kudos received';
	String get statsKudosSent => 'Kudos sent';
	String get statsHeartsReceived => 'Hearts received';
	String get statsBoxesOpened => 'Secret boxes opened';
	String get statsBoxesUnopened => 'Secret boxes unopened';
	String get openSecretBox => 'Open secret box';
	String get top10Title => '10 SUNNERS WITH LATEST GIFTS';
	String get searchSunner => 'Search sunner';
	String get totalKudos => '{count} KUDOS';
	String get pageIndicator => '{current}/{total}';
	String get sent => 'sent';
	String get timeAgo => '{time} ago';
	String get justNow => 'Just now';
	String get daysAgo => '{count} days ago';
	String get hoursAgo => '{count} hours ago';
	String get minutesAgo => '{count} minutes ago';
	String get anonymous => 'Anonymous';
	String get selectHashtag => 'Select Hashtag';
	String get selectDepartment => 'Select Department';
	String get clearFilter => 'Clear filter';
	String get ctaComingSoon => 'Send Kudos — coming soon';
	String get ctaAccessibilityLabel => 'Send kudos. Today, who do you want to send kudos to?';
	String get copyLinkAccessibility => 'Copy link';
	String get viewDetailAccessibility => 'View kudos detail';
	String get viewAllKudos => 'View all Kudos';
}

// Path: accessibility
class _StringsAccessibilityEn {
	_StringsAccessibilityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loginButton => 'Sign in with Google';
	String get languageSelector => 'Select language, currently: English';
	String get searchButton => 'Search';
	String get notificationButton => 'Notifications';
	String get fabWriteKudos => 'Write a kudos';
	String get fabViewKudos => 'View Kudos';
}

// Path: <root>
class _StringsVi implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsVi.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsVi _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsLoginVi login = _StringsLoginVi._(_root);
	@override late final _StringsHomeVi home = _StringsHomeVi._(_root);
	@override late final _StringsNavVi nav = _StringsNavVi._(_root);
	@override late final _StringsLanguageVi language = _StringsLanguageVi._(_root);
	@override late final _StringsErrorVi error = _StringsErrorVi._(_root);
	@override late final _StringsKudosVi kudos = _StringsKudosVi._(_root);
	@override late final _StringsAccessibilityVi accessibility = _StringsAccessibilityVi._(_root);
}

// Path: login
class _StringsLoginVi implements _StringsLoginEn {
	_StringsLoginVi._(this._root);

	@override final _StringsVi _root; // ignore: unused_field

	// Translations
	@override String get description => 'Bắt đầu hành trình của bạn cùng SAA 2025.\nĐăng nhập để khám phá!';
	@override String get button => 'LOGIN With Google';
	@override String get copyright => 'Bản quyền thuộc về Sun* © 2025';
}

// Path: home
class _StringsHomeVi implements _StringsHomeEn {
	_StringsHomeVi._(this._root);

	@override final _StringsVi _root; // ignore: unused_field

	// Translations
	@override String get comingSoon => 'Coming soon';
	@override String get days => 'DAYS';
	@override String get hours => 'HOURS';
	@override String get minutes => 'MINUTES';
	@override String get aboutAward => 'ABOUT AWARD';
	@override String get aboutKudos => 'ABOUT KUDOS';
	@override String get eventTime => 'Thời gian:';
	@override String get eventVenue => 'Địa điểm:';
	@override String get awardSystem => 'Hệ thống giải thưởng';
	@override String get awardSectionLabel => 'Sun* Annual Awards 2025';
	@override String get details => 'Chi tiết';
	@override String get recognitionMovement => 'Phong trào ghi nhận';
	@override String get sunKudos => 'Sun* Kudos';
	@override String get newFeatureSaa => 'ĐIỂM MỚI CỦA SAA 2025';
	@override String get kudosDescription => 'Hoạt động ghi nhận và cảm ơn đồng nghiệp - lần đầu tiên được diễn ra dành cho tất cả Sunner. Hoạt động sẽ được triển khai vào tháng 11/2025, khuyến khích người Sun* chia sẻ những lời ghi nhận, cảm ơn đồng nghiệp trên hệ thống do BTC công bố. Đây sẽ là chất liệu để Hội đồng Heads tham khảo trong quá trình lựa chọn người đạt giải.';
	@override String get awardsEmpty => 'Chưa có dữ liệu giải thưởng';
	@override String get errorRetry => 'Đã xảy ra lỗi. Nhấn để thử lại.';
	@override String get retry => 'Thử lại';
}

// Path: nav
class _StringsNavVi implements _StringsNavEn {
	_StringsNavVi._(this._root);

	@override final _StringsVi _root; // ignore: unused_field

	// Translations
	@override String get home => 'SAA 2025';
	@override String get awards => 'Awards';
	@override String get kudos => 'Kudos';
	@override String get profile => 'Profile';
}

// Path: language
class _StringsLanguageVi implements _StringsLanguageEn {
	_StringsLanguageVi._(this._root);

	@override final _StringsVi _root; // ignore: unused_field

	// Translations
	@override String get vi => 'VN';
	@override String get en => 'EN';
	@override String get selectorLabel => 'Chọn ngôn ngữ';
}

// Path: error
class _StringsErrorVi implements _StringsErrorEn {
	_StringsErrorVi._(this._root);

	@override final _StringsVi _root; // ignore: unused_field

	// Translations
	@override String get network => 'Không có kết nối mạng. Vui lòng thử lại.';
	@override String get auth => 'Đăng nhập thất bại. Vui lòng thử lại.';
}

// Path: kudos
class _StringsKudosVi implements _StringsKudosEn {
	_StringsKudosVi._(this._root);

	@override final _StringsVi _root; // ignore: unused_field

	// Translations
	@override String get sectionLabel => 'Sun* Annual Awards 2025';
	@override String get tagline => 'Hệ thống ghi nhận và cảm ơn';
	@override String get ctaText => 'Hôm nay, bạn muốn gửi kudos đến ai?';
	@override String get highlightTitle => 'HIGHLIGHT KUDOS';
	@override String get spotlightTitle => 'SPOTLIGHT BOARD';
	@override String get allKudosTitle => 'ALL KUDOS';
	@override String get viewAll => 'Xem tất cả';
	@override String get viewDetail => 'Xem chi tiết';
	@override String get copyLink => 'Copy Link';
	@override String get linkCopied => 'Đã sao chép liên kết';
	@override String get filterHashtag => 'Hashtag';
	@override String get filterDepartment => 'Phòng ban';
	@override String get emptyHighlight => 'Hiện tại chưa có Kudos nào.';
	@override String get emptyFeed => 'Chưa có Kudos nào được gửi.';
	@override String get emptySpotlight => 'Chưa có dữ liệu.';
	@override String get emptyTop10 => 'Chưa có dữ liệu xếp hạng.';
	@override String get emptyFilter => 'Không tìm thấy Kudos phù hợp.';
	@override String get errorRetry => 'Đã xảy ra lỗi. Nhấn để thử lại.';
	@override String get retry => 'Thử lại';
	@override String get statsKudosReceived => 'Số kudos nhận được';
	@override String get statsKudosSent => 'Số kudos đã gửi';
	@override String get statsHeartsReceived => 'Số hearts nhận được';
	@override String get statsBoxesOpened => 'Số hộp bí mật đã mở';
	@override String get statsBoxesUnopened => 'Số hộp bí mật chưa mở';
	@override String get openSecretBox => 'Mở hộp bí mật';
	@override String get top10Title => '10 SUNNER NHẬN QUÀ MỚI NHẤT';
	@override String get searchSunner => 'Tìm kiếm sunner';
	@override String get totalKudos => '{count} KUDOS';
	@override String get pageIndicator => '{current}/{total}';
	@override String get sent => 'sent';
	@override String get timeAgo => '{time} trước';
	@override String get justNow => 'Vừa xong';
	@override String get daysAgo => '{count} ngày trước';
	@override String get hoursAgo => '{count} giờ trước';
	@override String get minutesAgo => '{count} phút trước';
	@override String get anonymous => 'Ẩn danh';
	@override String get selectHashtag => 'Chọn Hashtag';
	@override String get selectDepartment => 'Chọn Phòng ban';
	@override String get clearFilter => 'Xóa bộ lọc';
	@override String get ctaComingSoon => 'Chức năng gửi Kudos — coming soon';
	@override String get ctaAccessibilityLabel => 'Gửi kudos. Hôm nay, bạn muốn gửi kudos đến ai?';
	@override String get copyLinkAccessibility => 'Sao chép liên kết';
	@override String get viewDetailAccessibility => 'Xem chi tiết kudos';
	@override String get viewAllKudos => 'View all Kudos';
}

// Path: accessibility
class _StringsAccessibilityVi implements _StringsAccessibilityEn {
	_StringsAccessibilityVi._(this._root);

	@override final _StringsVi _root; // ignore: unused_field

	// Translations
	@override String get loginButton => 'Đăng nhập bằng Google';
	@override String get languageSelector => 'Chọn ngôn ngữ, hiện tại: Tiếng Việt';
	@override String get searchButton => 'Tìm kiếm';
	@override String get notificationButton => 'Thông báo';
	@override String get fabWriteKudos => 'Viết lời cảm ơn';
	@override String get fabViewKudos => 'Xem Kudos';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'login.description': return 'Start your journey with SAA 2025.\nLog in to explore!';
			case 'login.button': return 'LOGIN With Google';
			case 'login.copyright': return 'Copyright belongs to Sun* © 2025';
			case 'home.comingSoon': return 'Coming soon';
			case 'home.days': return 'DAYS';
			case 'home.hours': return 'HOURS';
			case 'home.minutes': return 'MINUTES';
			case 'home.aboutAward': return 'ABOUT AWARD';
			case 'home.aboutKudos': return 'ABOUT KUDOS';
			case 'home.eventTime': return 'Time:';
			case 'home.eventVenue': return 'Venue:';
			case 'home.awardSystem': return 'Award System';
			case 'home.awardSectionLabel': return 'Sun* Annual Awards 2025';
			case 'home.details': return 'Details';
			case 'home.recognitionMovement': return 'Recognition Movement';
			case 'home.sunKudos': return 'Sun* Kudos';
			case 'home.newFeatureSaa': return 'NEW IN SAA 2025';
			case 'home.kudosDescription': return 'A recognition and gratitude initiative for colleagues - held for the first time for all Sunners. Launching in November 2025, Sun* Kudos encourages Sunners to share words of recognition and gratitude through the official platform. These messages will serve as valuable input for the Heads Council during the award selection process.';
			case 'home.awardsEmpty': return 'No award data available';
			case 'home.errorRetry': return 'Something went wrong. Tap to retry.';
			case 'home.retry': return 'Retry';
			case 'nav.home': return 'SAA 2025';
			case 'nav.awards': return 'Awards';
			case 'nav.kudos': return 'Kudos';
			case 'nav.profile': return 'Profile';
			case 'language.vi': return 'VN';
			case 'language.en': return 'EN';
			case 'language.selectorLabel': return 'Select language';
			case 'error.network': return 'No internet connection. Please try again.';
			case 'error.auth': return 'Login failed. Please try again.';
			case 'kudos.sectionLabel': return 'Sun* Annual Awards 2025';
			case 'kudos.tagline': return 'Recognition and appreciation system';
			case 'kudos.ctaText': return 'Today, who do you want to send kudos to?';
			case 'kudos.highlightTitle': return 'HIGHLIGHT KUDOS';
			case 'kudos.spotlightTitle': return 'SPOTLIGHT BOARD';
			case 'kudos.allKudosTitle': return 'ALL KUDOS';
			case 'kudos.viewAll': return 'View all';
			case 'kudos.viewDetail': return 'View detail';
			case 'kudos.copyLink': return 'Copy Link';
			case 'kudos.linkCopied': return 'Link copied';
			case 'kudos.filterHashtag': return 'Hashtag';
			case 'kudos.filterDepartment': return 'Department';
			case 'kudos.emptyHighlight': return 'No Kudos available yet.';
			case 'kudos.emptyFeed': return 'No Kudos have been sent yet.';
			case 'kudos.emptySpotlight': return 'No data available.';
			case 'kudos.emptyTop10': return 'No ranking data yet.';
			case 'kudos.emptyFilter': return 'No matching Kudos found.';
			case 'kudos.errorRetry': return 'Something went wrong. Tap to retry.';
			case 'kudos.retry': return 'Retry';
			case 'kudos.statsKudosReceived': return 'Kudos received';
			case 'kudos.statsKudosSent': return 'Kudos sent';
			case 'kudos.statsHeartsReceived': return 'Hearts received';
			case 'kudos.statsBoxesOpened': return 'Secret boxes opened';
			case 'kudos.statsBoxesUnopened': return 'Secret boxes unopened';
			case 'kudos.openSecretBox': return 'Open secret box';
			case 'kudos.top10Title': return '10 SUNNERS WITH LATEST GIFTS';
			case 'kudos.searchSunner': return 'Search sunner';
			case 'kudos.totalKudos': return '{count} KUDOS';
			case 'kudos.pageIndicator': return '{current}/{total}';
			case 'kudos.sent': return 'sent';
			case 'kudos.timeAgo': return '{time} ago';
			case 'kudos.justNow': return 'Just now';
			case 'kudos.daysAgo': return '{count} days ago';
			case 'kudos.hoursAgo': return '{count} hours ago';
			case 'kudos.minutesAgo': return '{count} minutes ago';
			case 'kudos.anonymous': return 'Anonymous';
			case 'kudos.selectHashtag': return 'Select Hashtag';
			case 'kudos.selectDepartment': return 'Select Department';
			case 'kudos.clearFilter': return 'Clear filter';
			case 'kudos.ctaComingSoon': return 'Send Kudos — coming soon';
			case 'kudos.ctaAccessibilityLabel': return 'Send kudos. Today, who do you want to send kudos to?';
			case 'kudos.copyLinkAccessibility': return 'Copy link';
			case 'kudos.viewDetailAccessibility': return 'View kudos detail';
			case 'kudos.viewAllKudos': return 'View all Kudos';
			case 'accessibility.loginButton': return 'Sign in with Google';
			case 'accessibility.languageSelector': return 'Select language, currently: English';
			case 'accessibility.searchButton': return 'Search';
			case 'accessibility.notificationButton': return 'Notifications';
			case 'accessibility.fabWriteKudos': return 'Write a kudos';
			case 'accessibility.fabViewKudos': return 'View Kudos';
			default: return null;
		}
	}
}

extension on _StringsVi {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'login.description': return 'Bắt đầu hành trình của bạn cùng SAA 2025.\nĐăng nhập để khám phá!';
			case 'login.button': return 'LOGIN With Google';
			case 'login.copyright': return 'Bản quyền thuộc về Sun* © 2025';
			case 'home.comingSoon': return 'Coming soon';
			case 'home.days': return 'DAYS';
			case 'home.hours': return 'HOURS';
			case 'home.minutes': return 'MINUTES';
			case 'home.aboutAward': return 'ABOUT AWARD';
			case 'home.aboutKudos': return 'ABOUT KUDOS';
			case 'home.eventTime': return 'Thời gian:';
			case 'home.eventVenue': return 'Địa điểm:';
			case 'home.awardSystem': return 'Hệ thống giải thưởng';
			case 'home.awardSectionLabel': return 'Sun* Annual Awards 2025';
			case 'home.details': return 'Chi tiết';
			case 'home.recognitionMovement': return 'Phong trào ghi nhận';
			case 'home.sunKudos': return 'Sun* Kudos';
			case 'home.newFeatureSaa': return 'ĐIỂM MỚI CỦA SAA 2025';
			case 'home.kudosDescription': return 'Hoạt động ghi nhận và cảm ơn đồng nghiệp - lần đầu tiên được diễn ra dành cho tất cả Sunner. Hoạt động sẽ được triển khai vào tháng 11/2025, khuyến khích người Sun* chia sẻ những lời ghi nhận, cảm ơn đồng nghiệp trên hệ thống do BTC công bố. Đây sẽ là chất liệu để Hội đồng Heads tham khảo trong quá trình lựa chọn người đạt giải.';
			case 'home.awardsEmpty': return 'Chưa có dữ liệu giải thưởng';
			case 'home.errorRetry': return 'Đã xảy ra lỗi. Nhấn để thử lại.';
			case 'home.retry': return 'Thử lại';
			case 'nav.home': return 'SAA 2025';
			case 'nav.awards': return 'Awards';
			case 'nav.kudos': return 'Kudos';
			case 'nav.profile': return 'Profile';
			case 'language.vi': return 'VN';
			case 'language.en': return 'EN';
			case 'language.selectorLabel': return 'Chọn ngôn ngữ';
			case 'error.network': return 'Không có kết nối mạng. Vui lòng thử lại.';
			case 'error.auth': return 'Đăng nhập thất bại. Vui lòng thử lại.';
			case 'kudos.sectionLabel': return 'Sun* Annual Awards 2025';
			case 'kudos.tagline': return 'Hệ thống ghi nhận và cảm ơn';
			case 'kudos.ctaText': return 'Hôm nay, bạn muốn gửi kudos đến ai?';
			case 'kudos.highlightTitle': return 'HIGHLIGHT KUDOS';
			case 'kudos.spotlightTitle': return 'SPOTLIGHT BOARD';
			case 'kudos.allKudosTitle': return 'ALL KUDOS';
			case 'kudos.viewAll': return 'Xem tất cả';
			case 'kudos.viewDetail': return 'Xem chi tiết';
			case 'kudos.copyLink': return 'Copy Link';
			case 'kudos.linkCopied': return 'Đã sao chép liên kết';
			case 'kudos.filterHashtag': return 'Hashtag';
			case 'kudos.filterDepartment': return 'Phòng ban';
			case 'kudos.emptyHighlight': return 'Hiện tại chưa có Kudos nào.';
			case 'kudos.emptyFeed': return 'Chưa có Kudos nào được gửi.';
			case 'kudos.emptySpotlight': return 'Chưa có dữ liệu.';
			case 'kudos.emptyTop10': return 'Chưa có dữ liệu xếp hạng.';
			case 'kudos.emptyFilter': return 'Không tìm thấy Kudos phù hợp.';
			case 'kudos.errorRetry': return 'Đã xảy ra lỗi. Nhấn để thử lại.';
			case 'kudos.retry': return 'Thử lại';
			case 'kudos.statsKudosReceived': return 'Số kudos nhận được';
			case 'kudos.statsKudosSent': return 'Số kudos đã gửi';
			case 'kudos.statsHeartsReceived': return 'Số hearts nhận được';
			case 'kudos.statsBoxesOpened': return 'Số hộp bí mật đã mở';
			case 'kudos.statsBoxesUnopened': return 'Số hộp bí mật chưa mở';
			case 'kudos.openSecretBox': return 'Mở hộp bí mật';
			case 'kudos.top10Title': return '10 SUNNER NHẬN QUÀ MỚI NHẤT';
			case 'kudos.searchSunner': return 'Tìm kiếm sunner';
			case 'kudos.totalKudos': return '{count} KUDOS';
			case 'kudos.pageIndicator': return '{current}/{total}';
			case 'kudos.sent': return 'sent';
			case 'kudos.timeAgo': return '{time} trước';
			case 'kudos.justNow': return 'Vừa xong';
			case 'kudos.daysAgo': return '{count} ngày trước';
			case 'kudos.hoursAgo': return '{count} giờ trước';
			case 'kudos.minutesAgo': return '{count} phút trước';
			case 'kudos.anonymous': return 'Ẩn danh';
			case 'kudos.selectHashtag': return 'Chọn Hashtag';
			case 'kudos.selectDepartment': return 'Chọn Phòng ban';
			case 'kudos.clearFilter': return 'Xóa bộ lọc';
			case 'kudos.ctaComingSoon': return 'Chức năng gửi Kudos — coming soon';
			case 'kudos.ctaAccessibilityLabel': return 'Gửi kudos. Hôm nay, bạn muốn gửi kudos đến ai?';
			case 'kudos.copyLinkAccessibility': return 'Sao chép liên kết';
			case 'kudos.viewDetailAccessibility': return 'Xem chi tiết kudos';
			case 'kudos.viewAllKudos': return 'View all Kudos';
			case 'accessibility.loginButton': return 'Đăng nhập bằng Google';
			case 'accessibility.languageSelector': return 'Chọn ngôn ngữ, hiện tại: Tiếng Việt';
			case 'accessibility.searchButton': return 'Tìm kiếm';
			case 'accessibility.notificationButton': return 'Thông báo';
			case 'accessibility.fabWriteKudos': return 'Viết lời cảm ơn';
			case 'accessibility.fabViewKudos': return 'Xem Kudos';
			default: return null;
		}
	}
}
