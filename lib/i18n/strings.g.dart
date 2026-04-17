/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 372 (186 per locale)
///
/// Built on 2026-04-16 at 10:22 UTC

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
	late final _StringsHomeVi home = _StringsHomeVi._(_root);
	late final _StringsNavVi nav = _StringsNavVi._(_root);
	late final _StringsLanguageVi language = _StringsLanguageVi._(_root);
	late final _StringsErrorVi error = _StringsErrorVi._(_root);
	late final _StringsAwardVi award = _StringsAwardVi._(_root);
	late final _StringsKudosVi kudos = _StringsKudosVi._(_root);
	late final _StringsAccessibilityVi accessibility = _StringsAccessibilityVi._(_root);
	late final _StringsProfileVi profile = _StringsProfileVi._(_root);
	late final _StringsSendKudosVi sendKudos = _StringsSendKudosVi._(_root);
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

// Path: home
class _StringsHomeVi {
	_StringsHomeVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get comingSoon => 'Coming soon';
	String get days => 'DAYS';
	String get hours => 'HOURS';
	String get minutes => 'MINUTES';
	String get aboutAward => 'ABOUT AWARD';
	String get aboutKudos => 'ABOUT KUDOS';
	String get eventTime => 'Thời gian:';
	String get eventVenue => 'Địa điểm:';
	String get awardSystem => 'Hệ thống giải thưởng';
	String get awardSectionLabel => 'Sun* Annual Awards 2025';
	String get details => 'Chi tiết';
	String get recognitionMovement => 'Phong trào ghi nhận';
	String get sunKudos => 'Sun* Kudos';
	String get newFeatureSaa => 'ĐIỂM MỚI CỦA SAA 2025';
	String get kudosDescription => 'Hoạt động ghi nhận và cảm ơn đồng nghiệp - lần đầu tiên được diễn ra dành cho tất cả Sunner. Hoạt động sẽ được triển khai vào tháng 11/2025, khuyến khích người Sun* chia sẻ những lời ghi nhận, cảm ơn đồng nghiệp trên hệ thống do BTC công bố. Đây sẽ là chất liệu để Hội đồng Heads tham khảo trong quá trình lựa chọn người đạt giải.';
	String get awardsEmpty => 'Chưa có dữ liệu giải thưởng';
	String get errorRetry => 'Đã xảy ra lỗi. Nhấn để thử lại.';
	String get retry => 'Thử lại';
}

// Path: nav
class _StringsNavVi {
	_StringsNavVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get home => 'SAA 2025';
	String get awards => 'Awards';
	String get kudos => 'Kudos';
	String get profile => 'Profile';
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

// Path: award
class _StringsAwardVi {
	_StringsAwardVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get recognitionSystem => 'Hệ thống ghi nhận và cảm ơn';
	String get awardSystemTitle => 'Hệ thống giải thưởng\nSAA 2025';
	String get awardQuantityLabel => 'Số lượng giải thưởng';
	String get awardValueLabel => 'Giá trị giải thưởng';
	String get dropdownHint => 'Chọn loại giải thưởng';
}

// Path: kudos
class _StringsKudosVi {
	_StringsKudosVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sectionLabel => 'Sun* Annual Awards 2025';
	String get tagline => 'Hệ thống ghi nhận và cảm ơn';
	String get ctaText => 'Hôm nay, bạn muốn gửi kudos đến ai?';
	String get highlightTitle => 'HIGHLIGHT KUDOS';
	String get spotlightTitle => 'SPOTLIGHT BOARD';
	String get allKudosTitle => 'ALL KUDOS';
	String get viewAll => 'Xem tất cả';
	String get viewDetail => 'Xem chi tiết';
	String get copyLink => 'Copy Link';
	String get linkCopied => 'Đã sao chép liên kết';
	String get filterHashtag => 'Hashtag';
	String get filterDepartment => 'Phòng ban';
	String get emptyHighlight => 'Hiện tại chưa có Kudos nào.';
	String get emptyFeed => 'Chưa có Kudos nào được gửi.';
	String get emptySpotlight => 'Chưa có dữ liệu.';
	String get emptyTop10 => 'Chưa có dữ liệu xếp hạng.';
	String get emptyFilter => 'Không tìm thấy Kudos phù hợp.';
	String get errorRetry => 'Đã xảy ra lỗi. Nhấn để thử lại.';
	String get retry => 'Thử lại';
	String get statsKudosReceived => 'Số kudos nhận được';
	String get statsKudosSent => 'Số kudos đã gửi';
	String get statsHeartsReceived => 'Số hearts nhận được';
	String get statsBoxesOpened => 'Số hộp bí mật đã mở';
	String get statsBoxesUnopened => 'Số hộp bí mật chưa mở';
	String get openSecretBox => 'Mở hộp bí mật';
	String get top10Title => '10 SUNNER NHẬN QUÀ MỚI NHẤT';
	String get searchSunner => 'Tìm kiếm sunner';
	String get totalKudos => '{count} KUDOS';
	String get liveFeedEntry => '{timestamp} {name} đã nhận được một Kudos mới';
	String get pageIndicator => '{current}/{total}';
	String get sent => 'sent';
	String get timeAgo => '{time} trước';
	String get justNow => 'Vừa xong';
	String get daysAgo => '{count} ngày trước';
	String get hoursAgo => '{count} giờ trước';
	String get minutesAgo => '{count} phút trước';
	String get anonymous => 'Ẩn danh';
	String get selectHashtag => 'Chọn Hashtag';
	String get selectDepartment => 'Chọn Phòng ban';
	String get clearFilter => 'Xóa bộ lọc';
	String get ctaComingSoon => 'Chức năng gửi Kudos — coming soon';
	String get ctaAccessibilityLabel => 'Gửi kudos. Hôm nay, bạn muốn gửi kudos đến ai?';
	String get copyLinkAccessibility => 'Sao chép liên kết';
	String get viewDetailAccessibility => 'Xem chi tiết kudos';
	String get viewAllKudos => 'View all Kudos';
	String get allKudosNavbarTitle => 'All Kudos';
	String get allKudosPullToRefresh => 'Kéo xuống để tải lại';
	String get allKudosLoadingMore => 'Đang tải thêm...';
	String get allKudosEmpty => 'Chưa có kudos nào';
	String get allKudosLoadError => 'Không thể tải danh sách kudos. Vui lòng thử lại.';
	String get allKudosRetry => 'Thử lại';
	String get filterAll => 'Tất cả';
	String get filterNoHashtags => 'Chưa có hashtag nào';
	String get filterNoDepartments => 'Chưa có phòng ban nào';
	String get filterLoadError => 'Không thể tải bộ lọc';
	String get filterTagSelected => 'Đã chọn';
	String get filterHashtagAccessibility => 'Lọc theo hashtag';
	String get filterDepartmentAccessibility => 'Lọc theo phòng ban';
	String get detailTitle => 'Chi tiết Kudos';
	String get anonymousSender => 'Người gửi ẩn danh';
	String get kudosNotFound => 'Kudos không tồn tại hoặc đã bị xoá.';
	String get noContent => '(Không có nội dung)';
	String get goBack => 'Quay lại';
	String get networkError => 'Mất kết nối mạng. Vui lòng thử lại.';
	String get heartError => 'Không thể thực hiện. Vui lòng thử lại.';
	String get avatarAccessibility => 'Ảnh đại diện của {name}';
	String get anonymousAvatarAccessibility => 'Ảnh đại diện người gửi ẩn danh';
	String get attachedImageAccessibility => 'Ảnh đính kèm {index}';
	String get deletedUser => 'Người dùng không tồn tại';
}

// Path: accessibility
class _StringsAccessibilityVi {
	_StringsAccessibilityVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loginButton => 'Đăng nhập bằng Google';
	String get languageSelector => 'Chọn ngôn ngữ, hiện tại: Tiếng Việt';
	String get searchButton => 'Tìm kiếm';
	String get notificationButton => 'Thông báo';
	String get fabWriteKudos => 'Viết lời cảm ơn';
	String get fabViewKudos => 'Xem Kudos';
	String get kudosDetailButton => 'Mở trang chi tiết Sun* Kudos';
	String get awardBadge => 'Huy hiệu giải';
}

// Path: profile
class _StringsProfileVi {
	_StringsProfileVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Hồ sơ';
	String get myIconCollection => 'Bộ sưu tập icon của tôi';
	String get kudosReceived => 'Kudos nhận được';
	String get kudosSent => 'Kudos đã gửi';
	String get heartsReceived => 'Hearts nhận được';
	String get secretBoxesOpened => 'Hộp bí mật đã mở';
	String get secretBoxesUnopened => 'Hộp bí mật chưa mở';
	String get openSecretBox => 'Mở hộp bí mật';
	String get kudosHistory => 'Lịch sử Kudos';
	String get filterReceived => 'Đã nhận';
	String get filterSent => 'Đã gửi';
	String get noBadges => 'Chưa có huy hiệu nào.';
	String get noKudosHistory => 'Chưa có Kudos nào.';
	String get sendThanks => 'Gửi lời cảm ơn';
	String get badgeCollection => 'Bộ sưu tập huy hiệu';
	String get userNotFound => 'Không tìm thấy người dùng.';
	String get loadError => 'Đã xảy ra lỗi. Nhấn để thử lại.';
	String get retry => 'Thử lại';
	String get pullToRefresh => 'Kéo xuống để tải lại';
	String get loadingMore => 'Đang tải thêm...';
	String get kudosTitle => 'KUDOS';
	String get saaAwards => 'Sun* Annual Awards 2025';
	String get spam => 'Spam';
}

// Path: sendKudos
class _StringsSendKudosVi {
	_StringsSendKudosVi._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'New Kudo';
	String get headerSubtitle => 'Gửi lời cám ơn và ghi nhận đến đồng đội';
	String get recipientLabel => 'Người nhận *';
	String get recipientPlaceholder => 'Tìm kiếm';
	String get titleLabel => 'Danh hiệu *';
	String get titlePlaceholder => 'Danh tặng một danh hiệu cho...';
	String get titleHint => 'Ví dụ: Người truyền động lực cho tôi.\nDanh hiệu sẽ hiển thị trên làm tiêu đề Kudos của bạn.';
	String get hashtagLabel => 'Hashtag *';
	String get hashtagPlaceholder => 'Chọn hashtag';
	String get messageLabel => 'Lời nhắn *';
	String get messagePlaceholder => 'Hãy gửi gắm lời cám ơn và ghi nhận đến đồng đội tại đây nhé!';
	String get anonymousLabel => 'Gửi ẩn danh';
	String get anonymousHint => 'Người nhận sẽ không biết bạn là ai';
	String get sendButton => 'Gửi đi';
	String get cancelButton => 'Huỷ';
	String get sending => 'Đang gửi...';
	String get sendSuccess => 'Gửi Kudos thành công! 🎉';
	String get sendError => 'Gửi Kudos thất bại. Vui lòng thử lại.';
	String get cancelTitle => 'Huỷ gửi Kudos?';
	String get cancelMessage => 'Nội dung bạn đã nhập sẽ bị mất. Bạn có chắc muốn huỷ?';
	String get cancelConfirm => 'Huỷ';
	String get cancelDismiss => 'Tiếp tục';
	String get validationRequired => 'Vui lòng điền đầy đủ thông tin bắt buộc.';
	String get validationRecipient => 'Vui lòng chọn người nhận.';
	String get validationTitle => 'Vui lòng nhập danh hiệu.';
	String get validationMessage => 'Vui lòng nhập lời nhắn.';
	String get validationHashtag => 'Vui lòng chọn ít nhất 1 hashtag.';
	String get validationSelfSend => 'Bạn không thể gửi Kudos cho chính mình.';
	String get validationMessageTooLong => 'Lời nhắn không được quá {max} ký tự.';
	String get validationTitleTooLong => 'Danh hiệu không được quá {max} ký tự.';
	String get hashtagMaxReached => 'Tối đa {max} hashtag';
	String get hashtagEmpty => 'Chưa có hashtag nào';
	String get hashtagLoadError => 'Không thể tải hashtag';
	String get recipientEmpty => 'Không tìm thấy kết quả';
	String get recipientLoadError => 'Không thể tải danh sách';
	String get recipientMinChars => 'Nhập ít nhất 2 ký tự để tìm kiếm';
	String get imageAttach => 'Đính kèm ảnh';
	String get imageMaxReached => 'Tối đa {max} ảnh';
	String get imageFormatError => 'Định dạng ảnh không hỗ trợ. Chỉ chấp nhận JPG, PNG, HEIC.';
	String get imageSizeError => 'Ảnh không được quá {max}MB.';
	String get imageUploadError => 'Tải ảnh lên thất bại. Vui lòng thử lại.';
	String get communityStandards => 'Tiêu chuẩn cộng đồng';
	String get mentionHint => 'Bạn có thể \'@ + tên\' để nhắc tới đồng nghiệp khác';
	String get charCount => '{current}/{max}';
	String get searchError => 'Đã xảy ra lỗi. Vui lòng thử lại.';
	String get searchNetworkError => 'Không thể tìm kiếm. Kiểm tra kết nối mạng.';
	String get retryButton => 'Thử lại';
	String get validationBanner => 'Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!';
	String get anonymousNicknamePlaceholder => 'Nhập nickname ẩn danh (tùy chọn)';
	String get anonymousNicknameHint => 'Để trống sẽ hiển thị \'Người gửi ẩn danh\'';
	String get usersLoadError => 'Không thể tải danh sách người dùng';
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
	@override late final _StringsHomeEn home = _StringsHomeEn._(_root);
	@override late final _StringsNavEn nav = _StringsNavEn._(_root);
	@override late final _StringsLanguageEn language = _StringsLanguageEn._(_root);
	@override late final _StringsErrorEn error = _StringsErrorEn._(_root);
	@override late final _StringsAwardEn award = _StringsAwardEn._(_root);
	@override late final _StringsKudosEn kudos = _StringsKudosEn._(_root);
	@override late final _StringsAccessibilityEn accessibility = _StringsAccessibilityEn._(_root);
	@override late final _StringsProfileEn profile = _StringsProfileEn._(_root);
	@override late final _StringsSendKudosEn sendKudos = _StringsSendKudosEn._(_root);
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

// Path: home
class _StringsHomeEn implements _StringsHomeVi {
	_StringsHomeEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get comingSoon => 'Coming soon';
	@override String get days => 'DAYS';
	@override String get hours => 'HOURS';
	@override String get minutes => 'MINUTES';
	@override String get aboutAward => 'ABOUT AWARD';
	@override String get aboutKudos => 'ABOUT KUDOS';
	@override String get eventTime => 'Time:';
	@override String get eventVenue => 'Venue:';
	@override String get awardSystem => 'Award System';
	@override String get awardSectionLabel => 'Sun* Annual Awards 2025';
	@override String get details => 'Details';
	@override String get recognitionMovement => 'Recognition Movement';
	@override String get sunKudos => 'Sun* Kudos';
	@override String get newFeatureSaa => 'NEW IN SAA 2025';
	@override String get kudosDescription => 'A recognition and gratitude initiative for colleagues - held for the first time for all Sunners. Launching in November 2025, Sun* Kudos encourages Sunners to share words of recognition and gratitude through the official platform. These messages will serve as valuable input for the Heads Council during the award selection process.';
	@override String get awardsEmpty => 'No award data available';
	@override String get errorRetry => 'Something went wrong. Tap to retry.';
	@override String get retry => 'Retry';
}

// Path: nav
class _StringsNavEn implements _StringsNavVi {
	_StringsNavEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get home => 'SAA 2025';
	@override String get awards => 'Awards';
	@override String get kudos => 'Kudos';
	@override String get profile => 'Profile';
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

// Path: award
class _StringsAwardEn implements _StringsAwardVi {
	_StringsAwardEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get recognitionSystem => 'Recognition and Gratitude System';
	@override String get awardSystemTitle => 'Award System\nSAA 2025';
	@override String get awardQuantityLabel => 'Number of Awards';
	@override String get awardValueLabel => 'Award Value';
	@override String get dropdownHint => 'Select award type';
}

// Path: kudos
class _StringsKudosEn implements _StringsKudosVi {
	_StringsKudosEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get sectionLabel => 'Sun* Annual Awards 2025';
	@override String get tagline => 'Recognition and appreciation system';
	@override String get ctaText => 'Today, who do you want to send kudos to?';
	@override String get highlightTitle => 'HIGHLIGHT KUDOS';
	@override String get spotlightTitle => 'SPOTLIGHT BOARD';
	@override String get allKudosTitle => 'ALL KUDOS';
	@override String get viewAll => 'View all';
	@override String get viewDetail => 'View detail';
	@override String get copyLink => 'Copy Link';
	@override String get linkCopied => 'Link copied';
	@override String get filterHashtag => 'Hashtag';
	@override String get filterDepartment => 'Department';
	@override String get emptyHighlight => 'No Kudos available yet.';
	@override String get emptyFeed => 'No Kudos have been sent yet.';
	@override String get emptySpotlight => 'No data available.';
	@override String get emptyTop10 => 'No ranking data yet.';
	@override String get emptyFilter => 'No matching Kudos found.';
	@override String get errorRetry => 'Something went wrong. Tap to retry.';
	@override String get retry => 'Retry';
	@override String get statsKudosReceived => 'Kudos received';
	@override String get statsKudosSent => 'Kudos sent';
	@override String get statsHeartsReceived => 'Hearts received';
	@override String get statsBoxesOpened => 'Secret boxes opened';
	@override String get statsBoxesUnopened => 'Secret boxes unopened';
	@override String get openSecretBox => 'Open secret box';
	@override String get top10Title => '10 SUNNERS WITH LATEST GIFTS';
	@override String get searchSunner => 'Search sunner';
	@override String get totalKudos => '{count} KUDOS';
	@override String get liveFeedEntry => '{timestamp} {name} has received a new Kudos';
	@override String get pageIndicator => '{current}/{total}';
	@override String get sent => 'sent';
	@override String get timeAgo => '{time} ago';
	@override String get justNow => 'Just now';
	@override String get daysAgo => '{count} days ago';
	@override String get hoursAgo => '{count} hours ago';
	@override String get minutesAgo => '{count} minutes ago';
	@override String get anonymous => 'Anonymous';
	@override String get selectHashtag => 'Select Hashtag';
	@override String get selectDepartment => 'Select Department';
	@override String get clearFilter => 'Clear filter';
	@override String get ctaComingSoon => 'Send Kudos — coming soon';
	@override String get ctaAccessibilityLabel => 'Send kudos. Today, who do you want to send kudos to?';
	@override String get copyLinkAccessibility => 'Copy link';
	@override String get viewDetailAccessibility => 'View kudos detail';
	@override String get viewAllKudos => 'View all Kudos';
	@override String get allKudosNavbarTitle => 'All Kudos';
	@override String get allKudosPullToRefresh => 'Pull to refresh';
	@override String get allKudosLoadingMore => 'Loading more...';
	@override String get allKudosEmpty => 'No kudos yet';
	@override String get allKudosLoadError => 'Failed to load kudos. Please try again.';
	@override String get allKudosRetry => 'Retry';
	@override String get filterAll => 'All';
	@override String get filterNoHashtags => 'No hashtags available';
	@override String get filterNoDepartments => 'No departments available';
	@override String get filterLoadError => 'Could not load filters';
	@override String get filterTagSelected => 'Selected';
	@override String get filterHashtagAccessibility => 'Filter by hashtag';
	@override String get filterDepartmentAccessibility => 'Filter by department';
	@override String get detailTitle => 'Kudos Detail';
	@override String get anonymousSender => 'Anonymous sender';
	@override String get kudosNotFound => 'This kudos no longer exists or has been removed.';
	@override String get noContent => '(No content)';
	@override String get goBack => 'Go back';
	@override String get networkError => 'Network error. Please try again.';
	@override String get heartError => 'Action failed. Please try again.';
	@override String get avatarAccessibility => 'Avatar of {name}';
	@override String get anonymousAvatarAccessibility => 'Anonymous sender avatar';
	@override String get attachedImageAccessibility => 'Attached image {index}';
	@override String get deletedUser => 'User no longer exists';
}

// Path: accessibility
class _StringsAccessibilityEn implements _StringsAccessibilityVi {
	_StringsAccessibilityEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get loginButton => 'Sign in with Google';
	@override String get languageSelector => 'Select language, currently: English';
	@override String get searchButton => 'Search';
	@override String get notificationButton => 'Notifications';
	@override String get fabWriteKudos => 'Write a kudos';
	@override String get fabViewKudos => 'View Kudos';
	@override String get kudosDetailButton => 'Open Sun* Kudos detail page';
	@override String get awardBadge => 'Award badge';
}

// Path: profile
class _StringsProfileEn implements _StringsProfileVi {
	_StringsProfileEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profile';
	@override String get myIconCollection => 'My icon collection';
	@override String get kudosReceived => 'Kudos received';
	@override String get kudosSent => 'Kudos sent';
	@override String get heartsReceived => 'Hearts received';
	@override String get secretBoxesOpened => 'Secret boxes opened';
	@override String get secretBoxesUnopened => 'Secret boxes unopened';
	@override String get openSecretBox => 'Open secret box';
	@override String get kudosHistory => 'Kudos History';
	@override String get filterReceived => 'Received';
	@override String get filterSent => 'Sent';
	@override String get noBadges => 'No badges earned yet.';
	@override String get noKudosHistory => 'No Kudos yet.';
	@override String get sendThanks => 'Send thanks';
	@override String get badgeCollection => 'Badge collection';
	@override String get userNotFound => 'User not found.';
	@override String get loadError => 'Something went wrong. Tap to retry.';
	@override String get retry => 'Retry';
	@override String get pullToRefresh => 'Pull to refresh';
	@override String get loadingMore => 'Loading more...';
	@override String get kudosTitle => 'KUDOS';
	@override String get saaAwards => 'Sun* Annual Awards 2025';
	@override String get spam => 'Spam';
}

// Path: sendKudos
class _StringsSendKudosEn implements _StringsSendKudosVi {
	_StringsSendKudosEn._(this._root);

	@override final _StringsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'New Kudo';
	@override String get headerSubtitle => 'Send your appreciation and recognition to your teammate';
	@override String get recipientLabel => 'Recipient *';
	@override String get recipientPlaceholder => 'Search';
	@override String get titleLabel => 'Title *';
	@override String get titlePlaceholder => 'Give a title for...';
	@override String get titleHint => 'E.g.: The one who inspires me.\nThe title will be displayed as the heading of your Kudos.';
	@override String get hashtagLabel => 'Hashtag *';
	@override String get hashtagPlaceholder => 'Select hashtag';
	@override String get messageLabel => 'Message *';
	@override String get messagePlaceholder => 'Send your appreciation and recognition to your teammate here!';
	@override String get anonymousLabel => 'Send anonymously';
	@override String get anonymousHint => 'The recipient won\'t know who you are';
	@override String get sendButton => 'Send';
	@override String get cancelButton => 'Cancel';
	@override String get sending => 'Sending...';
	@override String get sendSuccess => 'Kudos sent successfully! 🎉';
	@override String get sendError => 'Failed to send Kudos. Please try again.';
	@override String get cancelTitle => 'Cancel sending Kudos?';
	@override String get cancelMessage => 'Your content will be lost. Are you sure you want to cancel?';
	@override String get cancelConfirm => 'Cancel';
	@override String get cancelDismiss => 'Continue';
	@override String get validationRequired => 'Please fill in all required fields.';
	@override String get validationRecipient => 'Please select a recipient.';
	@override String get validationTitle => 'Please enter a title.';
	@override String get validationMessage => 'Please enter a message.';
	@override String get validationHashtag => 'Please select at least 1 hashtag.';
	@override String get validationSelfSend => 'You cannot send Kudos to yourself.';
	@override String get validationMessageTooLong => 'Message must not exceed {max} characters.';
	@override String get validationTitleTooLong => 'Title must not exceed {max} characters.';
	@override String get hashtagMaxReached => 'Maximum {max} hashtags';
	@override String get hashtagEmpty => 'No hashtags available';
	@override String get hashtagLoadError => 'Could not load hashtags';
	@override String get recipientEmpty => 'No results found';
	@override String get recipientLoadError => 'Could not load list';
	@override String get recipientMinChars => 'Enter at least 2 characters to search';
	@override String get imageAttach => 'Attach image';
	@override String get imageMaxReached => 'Maximum {max} images';
	@override String get imageFormatError => 'Unsupported image format. Only JPG, PNG, HEIC accepted.';
	@override String get imageSizeError => 'Image must not exceed {max}MB.';
	@override String get imageUploadError => 'Failed to upload image. Please try again.';
	@override String get communityStandards => 'Community standards';
	@override String get mentionHint => 'You can type \'@ + name\' to mention a colleague';
	@override String get charCount => '{current}/{max}';
	@override String get searchError => 'An error occurred. Please try again.';
	@override String get searchNetworkError => 'Cannot search. Check your network connection.';
	@override String get retryButton => 'Retry';
	@override String get validationBanner => 'You need to fill in Recipient, Message and Hashtag to send Kudos!';
	@override String get anonymousNicknamePlaceholder => 'Enter anonymous nickname (optional)';
	@override String get anonymousNicknameHint => 'Leave empty to display \'Anonymous sender\'';
	@override String get usersLoadError => 'Could not load user list';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
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
			case 'award.recognitionSystem': return 'Hệ thống ghi nhận và cảm ơn';
			case 'award.awardSystemTitle': return 'Hệ thống giải thưởng\nSAA 2025';
			case 'award.awardQuantityLabel': return 'Số lượng giải thưởng';
			case 'award.awardValueLabel': return 'Giá trị giải thưởng';
			case 'award.dropdownHint': return 'Chọn loại giải thưởng';
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
			case 'kudos.liveFeedEntry': return '{timestamp} {name} đã nhận được một Kudos mới';
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
			case 'kudos.allKudosNavbarTitle': return 'All Kudos';
			case 'kudos.allKudosPullToRefresh': return 'Kéo xuống để tải lại';
			case 'kudos.allKudosLoadingMore': return 'Đang tải thêm...';
			case 'kudos.allKudosEmpty': return 'Chưa có kudos nào';
			case 'kudos.allKudosLoadError': return 'Không thể tải danh sách kudos. Vui lòng thử lại.';
			case 'kudos.allKudosRetry': return 'Thử lại';
			case 'kudos.filterAll': return 'Tất cả';
			case 'kudos.filterNoHashtags': return 'Chưa có hashtag nào';
			case 'kudos.filterNoDepartments': return 'Chưa có phòng ban nào';
			case 'kudos.filterLoadError': return 'Không thể tải bộ lọc';
			case 'kudos.filterTagSelected': return 'Đã chọn';
			case 'kudos.filterHashtagAccessibility': return 'Lọc theo hashtag';
			case 'kudos.filterDepartmentAccessibility': return 'Lọc theo phòng ban';
			case 'kudos.detailTitle': return 'Chi tiết Kudos';
			case 'kudos.anonymousSender': return 'Người gửi ẩn danh';
			case 'kudos.kudosNotFound': return 'Kudos không tồn tại hoặc đã bị xoá.';
			case 'kudos.noContent': return '(Không có nội dung)';
			case 'kudos.goBack': return 'Quay lại';
			case 'kudos.networkError': return 'Mất kết nối mạng. Vui lòng thử lại.';
			case 'kudos.heartError': return 'Không thể thực hiện. Vui lòng thử lại.';
			case 'kudos.avatarAccessibility': return 'Ảnh đại diện của {name}';
			case 'kudos.anonymousAvatarAccessibility': return 'Ảnh đại diện người gửi ẩn danh';
			case 'kudos.attachedImageAccessibility': return 'Ảnh đính kèm {index}';
			case 'kudos.deletedUser': return 'Người dùng không tồn tại';
			case 'accessibility.loginButton': return 'Đăng nhập bằng Google';
			case 'accessibility.languageSelector': return 'Chọn ngôn ngữ, hiện tại: Tiếng Việt';
			case 'accessibility.searchButton': return 'Tìm kiếm';
			case 'accessibility.notificationButton': return 'Thông báo';
			case 'accessibility.fabWriteKudos': return 'Viết lời cảm ơn';
			case 'accessibility.fabViewKudos': return 'Xem Kudos';
			case 'accessibility.kudosDetailButton': return 'Mở trang chi tiết Sun* Kudos';
			case 'accessibility.awardBadge': return 'Huy hiệu giải';
			case 'profile.title': return 'Hồ sơ';
			case 'profile.myIconCollection': return 'Bộ sưu tập icon của tôi';
			case 'profile.kudosReceived': return 'Kudos nhận được';
			case 'profile.kudosSent': return 'Kudos đã gửi';
			case 'profile.heartsReceived': return 'Hearts nhận được';
			case 'profile.secretBoxesOpened': return 'Hộp bí mật đã mở';
			case 'profile.secretBoxesUnopened': return 'Hộp bí mật chưa mở';
			case 'profile.openSecretBox': return 'Mở hộp bí mật';
			case 'profile.kudosHistory': return 'Lịch sử Kudos';
			case 'profile.filterReceived': return 'Đã nhận';
			case 'profile.filterSent': return 'Đã gửi';
			case 'profile.noBadges': return 'Chưa có huy hiệu nào.';
			case 'profile.noKudosHistory': return 'Chưa có Kudos nào.';
			case 'profile.sendThanks': return 'Gửi lời cảm ơn';
			case 'profile.badgeCollection': return 'Bộ sưu tập huy hiệu';
			case 'profile.userNotFound': return 'Không tìm thấy người dùng.';
			case 'profile.loadError': return 'Đã xảy ra lỗi. Nhấn để thử lại.';
			case 'profile.retry': return 'Thử lại';
			case 'profile.pullToRefresh': return 'Kéo xuống để tải lại';
			case 'profile.loadingMore': return 'Đang tải thêm...';
			case 'profile.kudosTitle': return 'KUDOS';
			case 'profile.saaAwards': return 'Sun* Annual Awards 2025';
			case 'profile.spam': return 'Spam';
			case 'sendKudos.title': return 'New Kudo';
			case 'sendKudos.headerSubtitle': return 'Gửi lời cám ơn và ghi nhận đến đồng đội';
			case 'sendKudos.recipientLabel': return 'Người nhận *';
			case 'sendKudos.recipientPlaceholder': return 'Tìm kiếm';
			case 'sendKudos.titleLabel': return 'Danh hiệu *';
			case 'sendKudos.titlePlaceholder': return 'Danh tặng một danh hiệu cho...';
			case 'sendKudos.titleHint': return 'Ví dụ: Người truyền động lực cho tôi.\nDanh hiệu sẽ hiển thị trên làm tiêu đề Kudos của bạn.';
			case 'sendKudos.hashtagLabel': return 'Hashtag *';
			case 'sendKudos.hashtagPlaceholder': return 'Chọn hashtag';
			case 'sendKudos.messageLabel': return 'Lời nhắn *';
			case 'sendKudos.messagePlaceholder': return 'Hãy gửi gắm lời cám ơn và ghi nhận đến đồng đội tại đây nhé!';
			case 'sendKudos.anonymousLabel': return 'Gửi ẩn danh';
			case 'sendKudos.anonymousHint': return 'Người nhận sẽ không biết bạn là ai';
			case 'sendKudos.sendButton': return 'Gửi đi';
			case 'sendKudos.cancelButton': return 'Huỷ';
			case 'sendKudos.sending': return 'Đang gửi...';
			case 'sendKudos.sendSuccess': return 'Gửi Kudos thành công! 🎉';
			case 'sendKudos.sendError': return 'Gửi Kudos thất bại. Vui lòng thử lại.';
			case 'sendKudos.cancelTitle': return 'Huỷ gửi Kudos?';
			case 'sendKudos.cancelMessage': return 'Nội dung bạn đã nhập sẽ bị mất. Bạn có chắc muốn huỷ?';
			case 'sendKudos.cancelConfirm': return 'Huỷ';
			case 'sendKudos.cancelDismiss': return 'Tiếp tục';
			case 'sendKudos.validationRequired': return 'Vui lòng điền đầy đủ thông tin bắt buộc.';
			case 'sendKudos.validationRecipient': return 'Vui lòng chọn người nhận.';
			case 'sendKudos.validationTitle': return 'Vui lòng nhập danh hiệu.';
			case 'sendKudos.validationMessage': return 'Vui lòng nhập lời nhắn.';
			case 'sendKudos.validationHashtag': return 'Vui lòng chọn ít nhất 1 hashtag.';
			case 'sendKudos.validationSelfSend': return 'Bạn không thể gửi Kudos cho chính mình.';
			case 'sendKudos.validationMessageTooLong': return 'Lời nhắn không được quá {max} ký tự.';
			case 'sendKudos.validationTitleTooLong': return 'Danh hiệu không được quá {max} ký tự.';
			case 'sendKudos.hashtagMaxReached': return 'Tối đa {max} hashtag';
			case 'sendKudos.hashtagEmpty': return 'Chưa có hashtag nào';
			case 'sendKudos.hashtagLoadError': return 'Không thể tải hashtag';
			case 'sendKudos.recipientEmpty': return 'Không tìm thấy kết quả';
			case 'sendKudos.recipientLoadError': return 'Không thể tải danh sách';
			case 'sendKudos.recipientMinChars': return 'Nhập ít nhất 2 ký tự để tìm kiếm';
			case 'sendKudos.imageAttach': return 'Đính kèm ảnh';
			case 'sendKudos.imageMaxReached': return 'Tối đa {max} ảnh';
			case 'sendKudos.imageFormatError': return 'Định dạng ảnh không hỗ trợ. Chỉ chấp nhận JPG, PNG, HEIC.';
			case 'sendKudos.imageSizeError': return 'Ảnh không được quá {max}MB.';
			case 'sendKudos.imageUploadError': return 'Tải ảnh lên thất bại. Vui lòng thử lại.';
			case 'sendKudos.communityStandards': return 'Tiêu chuẩn cộng đồng';
			case 'sendKudos.mentionHint': return 'Bạn có thể \'@ + tên\' để nhắc tới đồng nghiệp khác';
			case 'sendKudos.charCount': return '{current}/{max}';
			case 'sendKudos.searchError': return 'Đã xảy ra lỗi. Vui lòng thử lại.';
			case 'sendKudos.searchNetworkError': return 'Không thể tìm kiếm. Kiểm tra kết nối mạng.';
			case 'sendKudos.retryButton': return 'Thử lại';
			case 'sendKudos.validationBanner': return 'Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!';
			case 'sendKudos.anonymousNicknamePlaceholder': return 'Nhập nickname ẩn danh (tùy chọn)';
			case 'sendKudos.anonymousNicknameHint': return 'Để trống sẽ hiển thị \'Người gửi ẩn danh\'';
			case 'sendKudos.usersLoadError': return 'Không thể tải danh sách người dùng';
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
			case 'award.recognitionSystem': return 'Recognition and Gratitude System';
			case 'award.awardSystemTitle': return 'Award System\nSAA 2025';
			case 'award.awardQuantityLabel': return 'Number of Awards';
			case 'award.awardValueLabel': return 'Award Value';
			case 'award.dropdownHint': return 'Select award type';
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
			case 'kudos.liveFeedEntry': return '{timestamp} {name} has received a new Kudos';
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
			case 'kudos.allKudosNavbarTitle': return 'All Kudos';
			case 'kudos.allKudosPullToRefresh': return 'Pull to refresh';
			case 'kudos.allKudosLoadingMore': return 'Loading more...';
			case 'kudos.allKudosEmpty': return 'No kudos yet';
			case 'kudos.allKudosLoadError': return 'Failed to load kudos. Please try again.';
			case 'kudos.allKudosRetry': return 'Retry';
			case 'kudos.filterAll': return 'All';
			case 'kudos.filterNoHashtags': return 'No hashtags available';
			case 'kudos.filterNoDepartments': return 'No departments available';
			case 'kudos.filterLoadError': return 'Could not load filters';
			case 'kudos.filterTagSelected': return 'Selected';
			case 'kudos.filterHashtagAccessibility': return 'Filter by hashtag';
			case 'kudos.filterDepartmentAccessibility': return 'Filter by department';
			case 'kudos.detailTitle': return 'Kudos Detail';
			case 'kudos.anonymousSender': return 'Anonymous sender';
			case 'kudos.kudosNotFound': return 'This kudos no longer exists or has been removed.';
			case 'kudos.noContent': return '(No content)';
			case 'kudos.goBack': return 'Go back';
			case 'kudos.networkError': return 'Network error. Please try again.';
			case 'kudos.heartError': return 'Action failed. Please try again.';
			case 'kudos.avatarAccessibility': return 'Avatar of {name}';
			case 'kudos.anonymousAvatarAccessibility': return 'Anonymous sender avatar';
			case 'kudos.attachedImageAccessibility': return 'Attached image {index}';
			case 'kudos.deletedUser': return 'User no longer exists';
			case 'accessibility.loginButton': return 'Sign in with Google';
			case 'accessibility.languageSelector': return 'Select language, currently: English';
			case 'accessibility.searchButton': return 'Search';
			case 'accessibility.notificationButton': return 'Notifications';
			case 'accessibility.fabWriteKudos': return 'Write a kudos';
			case 'accessibility.fabViewKudos': return 'View Kudos';
			case 'accessibility.kudosDetailButton': return 'Open Sun* Kudos detail page';
			case 'accessibility.awardBadge': return 'Award badge';
			case 'profile.title': return 'Profile';
			case 'profile.myIconCollection': return 'My icon collection';
			case 'profile.kudosReceived': return 'Kudos received';
			case 'profile.kudosSent': return 'Kudos sent';
			case 'profile.heartsReceived': return 'Hearts received';
			case 'profile.secretBoxesOpened': return 'Secret boxes opened';
			case 'profile.secretBoxesUnopened': return 'Secret boxes unopened';
			case 'profile.openSecretBox': return 'Open secret box';
			case 'profile.kudosHistory': return 'Kudos History';
			case 'profile.filterReceived': return 'Received';
			case 'profile.filterSent': return 'Sent';
			case 'profile.noBadges': return 'No badges earned yet.';
			case 'profile.noKudosHistory': return 'No Kudos yet.';
			case 'profile.sendThanks': return 'Send thanks';
			case 'profile.badgeCollection': return 'Badge collection';
			case 'profile.userNotFound': return 'User not found.';
			case 'profile.loadError': return 'Something went wrong. Tap to retry.';
			case 'profile.retry': return 'Retry';
			case 'profile.pullToRefresh': return 'Pull to refresh';
			case 'profile.loadingMore': return 'Loading more...';
			case 'profile.kudosTitle': return 'KUDOS';
			case 'profile.saaAwards': return 'Sun* Annual Awards 2025';
			case 'profile.spam': return 'Spam';
			case 'sendKudos.title': return 'New Kudo';
			case 'sendKudos.headerSubtitle': return 'Send your appreciation and recognition to your teammate';
			case 'sendKudos.recipientLabel': return 'Recipient *';
			case 'sendKudos.recipientPlaceholder': return 'Search';
			case 'sendKudos.titleLabel': return 'Title *';
			case 'sendKudos.titlePlaceholder': return 'Give a title for...';
			case 'sendKudos.titleHint': return 'E.g.: The one who inspires me.\nThe title will be displayed as the heading of your Kudos.';
			case 'sendKudos.hashtagLabel': return 'Hashtag *';
			case 'sendKudos.hashtagPlaceholder': return 'Select hashtag';
			case 'sendKudos.messageLabel': return 'Message *';
			case 'sendKudos.messagePlaceholder': return 'Send your appreciation and recognition to your teammate here!';
			case 'sendKudos.anonymousLabel': return 'Send anonymously';
			case 'sendKudos.anonymousHint': return 'The recipient won\'t know who you are';
			case 'sendKudos.sendButton': return 'Send';
			case 'sendKudos.cancelButton': return 'Cancel';
			case 'sendKudos.sending': return 'Sending...';
			case 'sendKudos.sendSuccess': return 'Kudos sent successfully! 🎉';
			case 'sendKudos.sendError': return 'Failed to send Kudos. Please try again.';
			case 'sendKudos.cancelTitle': return 'Cancel sending Kudos?';
			case 'sendKudos.cancelMessage': return 'Your content will be lost. Are you sure you want to cancel?';
			case 'sendKudos.cancelConfirm': return 'Cancel';
			case 'sendKudos.cancelDismiss': return 'Continue';
			case 'sendKudos.validationRequired': return 'Please fill in all required fields.';
			case 'sendKudos.validationRecipient': return 'Please select a recipient.';
			case 'sendKudos.validationTitle': return 'Please enter a title.';
			case 'sendKudos.validationMessage': return 'Please enter a message.';
			case 'sendKudos.validationHashtag': return 'Please select at least 1 hashtag.';
			case 'sendKudos.validationSelfSend': return 'You cannot send Kudos to yourself.';
			case 'sendKudos.validationMessageTooLong': return 'Message must not exceed {max} characters.';
			case 'sendKudos.validationTitleTooLong': return 'Title must not exceed {max} characters.';
			case 'sendKudos.hashtagMaxReached': return 'Maximum {max} hashtags';
			case 'sendKudos.hashtagEmpty': return 'No hashtags available';
			case 'sendKudos.hashtagLoadError': return 'Could not load hashtags';
			case 'sendKudos.recipientEmpty': return 'No results found';
			case 'sendKudos.recipientLoadError': return 'Could not load list';
			case 'sendKudos.recipientMinChars': return 'Enter at least 2 characters to search';
			case 'sendKudos.imageAttach': return 'Attach image';
			case 'sendKudos.imageMaxReached': return 'Maximum {max} images';
			case 'sendKudos.imageFormatError': return 'Unsupported image format. Only JPG, PNG, HEIC accepted.';
			case 'sendKudos.imageSizeError': return 'Image must not exceed {max}MB.';
			case 'sendKudos.imageUploadError': return 'Failed to upload image. Please try again.';
			case 'sendKudos.communityStandards': return 'Community standards';
			case 'sendKudos.mentionHint': return 'You can type \'@ + name\' to mention a colleague';
			case 'sendKudos.charCount': return '{current}/{max}';
			case 'sendKudos.searchError': return 'An error occurred. Please try again.';
			case 'sendKudos.searchNetworkError': return 'Cannot search. Check your network connection.';
			case 'sendKudos.retryButton': return 'Retry';
			case 'sendKudos.validationBanner': return 'You need to fill in Recipient, Message and Hashtag to send Kudos!';
			case 'sendKudos.anonymousNicknamePlaceholder': return 'Enter anonymous nickname (optional)';
			case 'sendKudos.anonymousNicknameHint': return 'Leave empty to display \'Anonymous sender\'';
			case 'sendKudos.usersLoadError': return 'Could not load user list';
			default: return null;
		}
	}
}
