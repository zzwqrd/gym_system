import 'package:flutter/material.dart';

/// String Extensions for Text Styling
extension StringTextExtensions on String {
  // Basic Text Widget with Style
  Text styled(TextStyle style) => Text(this, style: style);

  // Quick Text Widgets
  Text get text => Text(this);
  Text get h1 => Text(
    this,
    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  );
  Text get h2 => Text(
    this,
    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  );
  Text get h3 => Text(
    this,
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
  );
  Text get h4 => Text(
    this,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  );
  Text get h5 => Text(
    this,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  );
  Text get h6 => Text(
    this,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  );

  Text get body => Text(this, style: const TextStyle(fontSize: 16));
  Text get caption =>
      Text(this, style: const TextStyle(fontSize: 12, color: Colors.grey));
  Text get overline =>
      Text(this, style: const TextStyle(fontSize: 10, letterSpacing: 1.5));

  // Styled Text Shortcuts
  Text bold() =>
      Text(this, style: const TextStyle(fontWeight: FontWeight.bold));
  Text italic() =>
      Text(this, style: const TextStyle(fontStyle: FontStyle.italic));
  Text underline() =>
      Text(this, style: const TextStyle(decoration: TextDecoration.underline));

  Text colors(Color color) => Text(this, style: TextStyle(color: color));
  Text size(double size) => Text(this, style: TextStyle(fontSize: size));
  Text weight(FontWeight weight) =>
      Text(this, style: TextStyle(fontWeight: weight));

  // Advanced Text Widgets
  Text withStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? letterSpacing,
    double? height,
    String? fontFamily,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextStyle? style,
  }) => Text(
    this,
    style:
        style ??
        TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: decoration,
          letterSpacing: letterSpacing,
          height: height,
          fontFamily: fontFamily,
        ),
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
  );
  // Basic text widget
  Widget textWithoutStyle({
    TextStyle? style,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    Paint? background,
    Paint? foreground,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextBaseline? textBaseline,
    Locale? locale,
    bool? softWrap,
    StrutStyle? strutStyle,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) => Text(
    this,
    style: (style ?? const TextStyle()).copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      background: background,
      foreground: foreground,
      shadows: shadows,
      fontFeatures: fontFeatures,
      textBaseline: textBaseline,
      locale: locale,
    ),
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: softWrap,
    strutStyle: strutStyle,
    textWidthBasis: textWidthBasis,
    textHeightBehavior: textHeightBehavior,
  );

  // Display Text Extensions
  Widget displayLarge({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 1.12,
      letterSpacing: -0.25,
    ).merge(style).copyWith(color: color),
  );

  Widget displayMedium({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 1.16,
    ).merge(style).copyWith(color: color),
  );

  Widget displaySmall({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 1.22,
    ).merge(style).copyWith(color: color),
  );

  // Headline Extensions
  Widget headlineLarge({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.25,
    ).merge(style).copyWith(color: color),
  );

  Widget headlineMedium({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.29,
    ).merge(style).copyWith(color: color),
  );

  Widget headlineSmall({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.33,
    ).merge(style).copyWith(color: color),
  );

  // Title Extensions
  Widget titleLarge({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      height: 1.27,
    ).merge(style).copyWith(color: color),
  );

  Widget titleMedium({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.50,
      letterSpacing: 0.15,
    ).merge(style).copyWith(color: color),
  );

  Widget titleSmall({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
    ).merge(style).copyWith(color: color),
  );

  // Legacy Header Extensions (for backward compatibility)
  Widget h1WithoutStyle({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: -0.5,
    ).merge(style).copyWith(color: color),
  );

  Widget h2WithoutStyle({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      height: 1.3,
      letterSpacing: -0.5,
    ).merge(style).copyWith(color: color),
  );

  Widget h3WithoutStyle({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: -0.25,
    ).merge(style).copyWith(color: color),
  );

  Widget h4WithoutStyle({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ).merge(style).copyWith(color: color),
  );

  Widget h5WithoutStyle({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ).merge(style).copyWith(color: color),
  );

  Widget h6WithoutStyle({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      letterSpacing: 0.15,
    ).merge(style).copyWith(color: color),
  );

  // Body Text Extensions
  Widget bodyLarge({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.5,
    ).merge(style).copyWith(color: color),
  );

  Widget bodyMedium({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
    ).merge(style).copyWith(color: color),
  );

  Widget bodySmall({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
    ).merge(style).copyWith(color: color),
  );

  // Label Extensions
  Widget labelLarge({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
    ).merge(style).copyWith(color: color),
  );

  Widget labelMedium({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.33,
      letterSpacing: 0.5,
    ).merge(style).copyWith(color: color),
  );

  Widget labelSmall({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.5,
    ).merge(style).copyWith(color: color),
  );

  // Legacy Text Extensions
  Widget captionWithoutStyle({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
    ).merge(style).copyWith(color: color?.withValues(alpha: 0.7) ?? color),
  );

  Widget overlineWithoutStyle({Color? color, TextStyle? style}) => Text(
    this,
    style: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.5,
    ).merge(style).copyWith(color: color),
  );
}

// Arabic Text Extensions
extension ArabicTextExtensions on String {
  Text get arabicText => Text(
    this,
    textDirection: TextDirection.rtl,
    style: const TextStyle(fontFamily: 'Cairo'),
  );
}
