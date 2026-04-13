// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/.gitkeep
  String get aGitkeep => 'assets/icons/.gitkeep';

  /// Directory path: assets/icons/flags
  $AssetsIconsFlagsGen get flags => const $AssetsIconsFlagsGen();

  /// File path: assets/icons/ic_arrow_down.svg
  SvgGenImage get icArrowDown =>
      const SvgGenImage('assets/icons/ic_arrow_down.svg');

  /// File path: assets/icons/ic_arrow_open.svg
  SvgGenImage get icArrowOpen =>
      const SvgGenImage('assets/icons/ic_arrow_open.svg');

  /// File path: assets/icons/ic_award.svg
  SvgGenImage get icAward => const SvgGenImage('assets/icons/ic_award.svg');

  /// File path: assets/icons/ic_google.svg
  SvgGenImage get icGoogle => const SvgGenImage('assets/icons/ic_google.svg');

  /// File path: assets/icons/ic_home.svg
  SvgGenImage get icHome => const SvgGenImage('assets/icons/ic_home.svg');

  /// File path: assets/icons/ic_kudos.svg
  SvgGenImage get icKudos => const SvgGenImage('assets/icons/ic_kudos.svg');

  /// File path: assets/icons/ic_kudos_logo.svg
  SvgGenImage get icKudosLogo =>
      const SvgGenImage('assets/icons/ic_kudos_logo.svg');

  /// File path: assets/icons/ic_notification.svg
  SvgGenImage get icNotification =>
      const SvgGenImage('assets/icons/ic_notification.svg');

  /// File path: assets/icons/ic_pen.svg
  SvgGenImage get icPen => const SvgGenImage('assets/icons/ic_pen.svg');

  /// File path: assets/icons/ic_profile.svg
  SvgGenImage get icProfile => const SvgGenImage('assets/icons/ic_profile.svg');

  /// File path: assets/icons/ic_search.svg
  SvgGenImage get icSearch => const SvgGenImage('assets/icons/ic_search.svg');

  /// List of all assets
  List<dynamic> get values => [
    aGitkeep,
    icArrowDown,
    icArrowOpen,
    icAward,
    icGoogle,
    icHome,
    icKudos,
    icKudosLogo,
    icNotification,
    icPen,
    icProfile,
    icSearch,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/.gitkeep
  String get aGitkeep => 'assets/images/.gitkeep';

  /// Directory path: assets/images/home
  $AssetsImagesHomeGen get home => const $AssetsImagesHomeGen();

  /// File path: assets/images/keyvisual_bg.png
  AssetGenImage get keyvisualBg =>
      const AssetGenImage('assets/images/keyvisual_bg.png');

  /// File path: assets/images/root_further.png
  AssetGenImage get rootFurther =>
      const AssetGenImage('assets/images/root_further.png');

  /// File path: assets/images/saa_logo.png
  AssetGenImage get saaLogo =>
      const AssetGenImage('assets/images/saa_logo.png');

  /// List of all assets
  List<dynamic> get values => [aGitkeep, keyvisualBg, rootFurther, saaLogo];
}

class $AssetsIconsFlagsGen {
  const $AssetsIconsFlagsGen();

  /// File path: assets/icons/flags/.gitkeep
  String get aGitkeep => 'assets/icons/flags/.gitkeep';

  /// File path: assets/icons/flags/en.svg
  SvgGenImage get en => const SvgGenImage('assets/icons/flags/en.svg');

  /// File path: assets/icons/flags/vn.svg
  SvgGenImage get vn => const SvgGenImage('assets/icons/flags/vn.svg');

  /// List of all assets
  List<dynamic> get values => [aGitkeep, en, vn];
}

class $AssetsImagesHomeGen {
  const $AssetsImagesHomeGen();

  /// File path: assets/images/home/key_visual_bg.png
  AssetGenImage get keyVisualBg =>
      const AssetGenImage('assets/images/home/key_visual_bg.png');

  /// File path: assets/images/home/kudos_banner.png
  AssetGenImage get kudosBanner =>
      const AssetGenImage('assets/images/home/kudos_banner.png');

  /// File path: assets/images/home/logo_saa.png
  AssetGenImage get logoSaa =>
      const AssetGenImage('assets/images/home/logo_saa.png');

  /// File path: assets/images/home/root_further_logo.png
  AssetGenImage get rootFurtherLogo =>
      const AssetGenImage('assets/images/home/root_further_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    keyVisualBg,
    kudosBanner,
    logoSaa,
    rootFurtherLogo,
  ];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
