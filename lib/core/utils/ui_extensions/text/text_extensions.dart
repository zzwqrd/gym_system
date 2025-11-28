import 'package:flutter/material.dart';

/// Smart Text Extensions for String, num, and Text
extension SmartTextExtensions on dynamic {
  // Basic Text Widget with Style
  Text styled(TextStyle style) {
    if (this is Text) {
      final text = this as Text;
      return Text(
        text.data ?? '',
        style: (text.style ?? const TextStyle()).merge(style),
        textAlign: text.textAlign,
        maxLines: text.maxLines,
        overflow: text.overflow,
      );
    }
    return Text(toString(), style: style);
  }

  // Quick Text Widgets
  Text get text => this is Text ? this as Text : Text(toString());

  Text get h1 => withStyle(fontSize: 32, fontWeight: FontWeight.bold);
  Text get h2 => withStyle(fontSize: 28, fontWeight: FontWeight.bold);
  Text get h3 => withStyle(fontSize: 24, fontWeight: FontWeight.w600);
  Text get h4 => withStyle(fontSize: 20, fontWeight: FontWeight.w600);
  Text get h5 => withStyle(fontSize: 18, fontWeight: FontWeight.w500);
  Text get h6 => withStyle(fontSize: 16, fontWeight: FontWeight.w500);

  Text get body => withStyle(fontSize: 16);
  Text get caption => withStyle(fontSize: 12, color: Colors.grey);
  Text get overline => withStyle(fontSize: 10, letterSpacing: 1.5);

  // Styled Text Shortcuts
  Text bold() => withStyle(fontWeight: FontWeight.bold);
  Text italic() => withStyle(fontStyle: FontStyle.italic);
  Text underline() => withStyle(decoration: TextDecoration.underline);

  Text colors(Color color) => withStyle(color: color);
  Text size(double size) => withStyle(fontSize: size);
  Text weight(FontWeight weight) => withStyle(fontWeight: weight);

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
  }) {
    TextStyle newStyle = TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );

    if (this is Text) {
      final text = this as Text;
      return Text(
        text.data ?? '',
        style: (text.style ?? const TextStyle()).merge(newStyle),
        textAlign: textAlign ?? text.textAlign,
        maxLines: maxLines ?? text.maxLines,
        overflow: overflow ?? text.overflow,
      );
    }

    return Text(
      toString(),
      style: newStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  // Display Text Extensions
  Text displayLarge({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 1.12,
      letterSpacing: -0.25,
    ).merge(style).copyWith(color: color),
  );

  Text displayMedium({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 1.16,
    ).merge(style).copyWith(color: color),
  );

  Text displaySmall({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 1.22,
    ).merge(style).copyWith(color: color),
  );

  // Headline Extensions
  Text headlineLarge({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.25,
    ).merge(style).copyWith(color: color),
  );

  Text headlineMedium({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.29,
    ).merge(style).copyWith(color: color),
  );

  Text headlineSmall({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.33,
    ).merge(style).copyWith(color: color),
  );

  // Title Extensions
  Text titleLarge({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      height: 1.27,
    ).merge(style).copyWith(color: color),
  );

  Text titleMedium({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.50,
      letterSpacing: 0.15,
    ).merge(style).copyWith(color: color),
  );

  Text titleSmall({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
    ).merge(style).copyWith(color: color),
  );

  // Body Text Extensions
  Text bodyLarge({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.5,
    ).merge(style).copyWith(color: color),
  );

  Text bodyMedium({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
    ).merge(style).copyWith(color: color),
  );

  Text bodySmall({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
    ).merge(style).copyWith(color: color),
  );

  // Label Extensions
  Text labelLarge({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
    ).merge(style).copyWith(color: color),
  );

  Text labelMedium({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.33,
      letterSpacing: 0.5,
    ).merge(style).copyWith(color: color),
  );

  Text labelSmall({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.5,
    ).merge(style).copyWith(color: color),
  );

  // Legacy Header Extensions (for backward compatibility)
  Text h1WithoutStyle({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: -0.5,
    ).merge(style).copyWith(color: color),
  );

  Text h2WithoutStyle({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      height: 1.3,
      letterSpacing: -0.5,
    ).merge(style).copyWith(color: color),
  );

  Text h3WithoutStyle({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: -0.25,
    ).merge(style).copyWith(color: color),
  );

  Text h4WithoutStyle({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ).merge(style).copyWith(color: color),
  );

  Text h5WithoutStyle({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ).merge(style).copyWith(color: color),
  );

  Text h6WithoutStyle({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      letterSpacing: 0.15,
    ).merge(style).copyWith(color: color),
  );

  // Legacy Text Extensions
  Text captionWithoutStyle({Color? color, TextStyle? style}) => styled(
    const TextStyle(
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
    ).merge(style).copyWith(color: color?.withValues(alpha: 0.7) ?? color),
  );

  Text overlineWithoutStyle({Color? color, TextStyle? style}) => styled(
    const TextStyle(
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
