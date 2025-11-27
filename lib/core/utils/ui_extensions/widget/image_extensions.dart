import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../routes/app_routes_fun.dart';
import '../color/color_extensions.dart';
import '../sizing/size_extensions.dart';

/// Enhanced Image Extensions
extension AppImages on BuildContext {
  // Network Image with comprehensive options
  Widget networkImage(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    BorderRadius? borderRadius,
    Color? color,
    BlendMode? colorBlendMode,
    double? opacity,
    Duration fadeInDuration = const Duration(milliseconds: 300),
    Duration placeholderFadeInDuration = const Duration(milliseconds: 300),
    Map<String, String>? httpHeaders,
    bool useOldImageOnUrlChange = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      fadeInDuration: fadeInDuration,
      placeholderFadeInDuration: placeholderFadeInDuration,
      httpHeaders: httpHeaders,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      filterQuality: filterQuality,
      placeholder: (context, url) =>
          placeholder ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: navigatorKey.currentContext!.backgroundColor,
              borderRadius: borderRadius,
            ),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
            ),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image_outlined,
                  color: textHint,
                  size: navigatorKey.currentContext!.iconMD,
                ),
                if (height == null || height > 60) ...[
                  SizedBox(height: spacing1),
                  Text(
                    'فشل تحميل الصورة',
                    // style: labelSmall.copyWith(color: textHint),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
    );

    if (opacity != null) {
      imageWidget = Opacity(opacity: opacity, child: imageWidget);
    }
    if (borderRadius != null) {
      imageWidget = ClipRRect(borderRadius: borderRadius, child: imageWidget);
    }
    return imageWidget;
  }

  // Enhanced Asset Image
  Widget assetImage(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Color? color,
    BlendMode? colorBlendMode,
    BorderRadius? borderRadius,
    double? opacity,
    FilterQuality filterQuality = FilterQuality.low,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Widget? errorWidget,
  }) {
    Widget imageWidget;
    try {
      imageWidget = Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        color: color,
        colorBlendMode: colorBlendMode,
        filterQuality: filterQuality,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        alignment: alignment,
        repeat: repeat,
        errorBuilder: errorWidget != null
            ? (context, error, stackTrace) => errorWidget
            : (context, error, stackTrace) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: borderRadius,
                ),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: textHint,
                  size: iconMD,
                ),
              ),
      );
    } catch (e) {
      imageWidget =
          errorWidget ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            child: Icon(
              Icons.image_not_supported_outlined,
              color: textHint,
              size: iconMD,
            ),
          );
    }
    if (opacity != null) {
      imageWidget = Opacity(opacity: opacity, child: imageWidget);
    }
    if (borderRadius != null) {
      imageWidget = ClipRRect(borderRadius: borderRadius, child: imageWidget);
    }
    return imageWidget;
  }

  // Circular Image (Avatar)
  Widget circularImage(
    String imageUrl, {
    double radius = 24,
    Widget? placeholder,
    Widget? errorWidget,
    Color? backgroundColor,
    bool isAsset = false,
    Border? border,
    List<BoxShadow>? boxShadow,
    VoidCallback? onTap,
  }) {
    Widget avatar = Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? this.backgroundColor,
        border: border,
        boxShadow: boxShadow,
      ),
      child: ClipOval(
        child: imageUrl.isEmpty
            ? (placeholder ?? Icon(Icons.person, size: radius, color: textHint))
            : isAsset
            ? assetImage(
                imageUrl,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                errorWidget:
                    placeholder ??
                    Icon(Icons.person, size: radius, color: textHint),
              )
            : networkImage(
                imageUrl,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                placeholder: placeholder,
                errorWidget:
                    errorWidget ??
                    placeholder ??
                    Icon(Icons.person, size: radius, color: textHint),
              ),
      ),
    );
    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }
    return avatar;
  }

  // Image with overlay and effects
  Widget imageWithOverlay(
    String imageUrl, {
    double? width,
    double? height,
    Widget? overlay,
    Color? overlayColor,
    double overlayOpacity = 0.3,
    BorderRadius? borderRadius,
    bool isAsset = false,
    BoxFit fit = BoxFit.cover,
    List<BoxShadow>? boxShadow,
    Gradient? overlayGradient,
    AlignmentGeometry overlayAlignment = Alignment.center,
  }) {
    Widget imageWidget = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Stack(
          children: [
            // Base Image
            isAsset
                ? assetImage(imageUrl, width: width, height: height, fit: fit)
                : networkImage(
                    imageUrl,
                    width: width,
                    height: height,
                    fit: fit,
                  ),
            // Color Overlay
            if (overlayColor != null)
              Container(
                width: width,
                height: height,
                color: overlayColor.withValues(alpha: overlayOpacity),
              ),
            // Gradient Overlay
            if (overlayGradient != null)
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(gradient: overlayGradient),
              ),
            // Custom Overlay Widget
            if (overlay != null)
              Positioned.fill(
                child: Align(alignment: overlayAlignment, child: overlay),
              ),
          ],
        ),
      ),
    );
    return imageWidget;
  }

  // Hero Image for page transitions
  Widget heroImage(
    String imageUrl, {
    required String heroTag,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    bool isAsset = false,
    VoidCallback? onTap,
    Widget? child,
  }) {
    Widget heroWidget = Hero(
      tag: heroTag,
      child: isAsset
          ? assetImage(
              imageUrl,
              width: width,
              height: height,
              fit: fit,
              borderRadius: borderRadius,
            )
          : networkImage(
              imageUrl,
              width: width,
              height: height,
              fit: fit,
              borderRadius: borderRadius,
            ),
    );
    if (child != null) {
      heroWidget = Stack(
        children: [
          heroWidget,
          Positioned.fill(child: child),
        ],
      );
    }
    if (onTap != null) {
      heroWidget = GestureDetector(onTap: onTap, child: heroWidget);
    }
    return heroWidget;
  }

  // Gallery Image Item
  Widget galleryImage(
    String imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    bool isAsset = false,
    VoidCallback? onTap,
    Widget? badge,
    Widget? overlay,
    bool showLoadingIndicator = true,
    String? heroTag,
  }) {
    Widget imageWidget = GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? radiusMD,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? radiusMD,
          child: Stack(
            children: [
              // Base Image
              isAsset
                  ? assetImage(imageUrl, width: width, height: height, fit: fit)
                  : networkImage(
                      imageUrl,
                      width: width,
                      height: height,
                      fit: fit,
                    ),
              // Overlay
              if (overlay != null) Positioned.fill(child: overlay),
              // Badge
              if (badge != null)
                Positioned(top: spacing2, right: spacing2, child: badge),
            ],
          ),
        ),
      ),
    );
    if (heroTag != null) {
      imageWidget = Hero(tag: heroTag, child: imageWidget);
    }
    return imageWidget;
  }
}
