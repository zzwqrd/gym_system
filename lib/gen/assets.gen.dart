/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart' as _lottie;

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Cairo-Black.ttf
  String get cairoBlack =>
      'assets/fonts/Cairo-Black.ttf';

  /// File path: assets/fonts/Cairo-Bold.ttf
  String get cairoBold =>
      'assets/fonts/Cairo-Bold.ttf';

  /// File path: assets/fonts/Cairo-ExtraBold.ttf
  String get cairoExtraBold =>
      'assets/fonts/Cairo-ExtraBold.ttf';

  /// File path: assets/fonts/Cairo-ExtraLight.ttf
  String get cairoExtraLight =>
      'assets/fonts/Cairo-ExtraLight.ttf';

  /// File path: assets/fonts/Cairo-Light.ttf
  String get cairoLight =>
      'assets/fonts/Cairo-Light.ttf';

  /// File path: assets/fonts/Cairo-Medium.ttf
  String get cairoMedium =>
      'assets/fonts/Cairo-Medium.ttf';

  /// File path: assets/fonts/Cairo-Regular.ttf
  String get cairoRegular =>
      'assets/fonts/Cairo-Regular.ttf';

  /// File path: assets/fonts/Cairo-SemiBold.ttf
  String get cairoSemiBold =>
      'assets/fonts/Cairo-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
    cairoBlack,
    cairoBold,
    cairoExtraBold,
    cairoExtraLight,
    cairoLight,
    cairoMedium,
    cairoRegular,
    cairoSemiBold,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/loading.json
  LottieGenImage get loading =>
      const LottieGenImage(
        'assets/icons/loading.json',
      );

  /// File path: assets/icons/profile_picture1.png
  AssetGenImage get profilePicture1 =>
      const AssetGenImage(
        'assets/icons/profile_picture1.png',
      );

  /// List of all assets
  List<dynamic> get values => [
    loading,
    profilePicture1,
  ];
}

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/lang/ar.json
  String get ar => 'assets/lang/ar.json';

  /// File path: assets/lang/en.json
  String get en => 'assets/lang/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $AssetsLoadingGen {
  const $AssetsLoadingGen();

  /// File path: assets/loading/lod.json
  LottieGenImage get lod => const LottieGenImage(
    'assets/loading/lod.json',
  );

  /// List of all assets
  List<LottieGenImage> get values => [lod];
}

class MyAssets {
  const MyAssets._();

  static const $AssetsFontsGen fonts =
      $AssetsFontsGen();
  static const $AssetsIconsGen icons =
      $AssetsIconsGen();
  static const $AssetsLangGen lang =
      $AssetsLangGen();
  static const $AssetsLoadingGen loading =
      $AssetsLoadingGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    AlignmentGeometry alignment =
        Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality =
        FilterQuality.medium,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(
    this._assetName, {
    this.flavors = const {},
  });

  final String _assetName;
  final Set<String> flavors;

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)?
    onLoaded,
    _lottie.LottieImageProviderFactory?
    imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(
      BuildContext,
      Widget,
      _lottie.LottieComposition?,
    )?
    frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
    _lottie.LottieDecoder? decoder,
    _lottie.RenderCache? renderCache,
    bool? backgroundLoading,
  }) {
    return _lottie.Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
      decoder: decoder,
      renderCache: renderCache,
      backgroundLoading: backgroundLoading,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
