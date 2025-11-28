import 'package:flutter/material.dart';

/// Comprehensive TextStyle Extensions for Flutter
extension TextStyleExtensions on TextStyle {
  // Font Weight Variations
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get black => copyWith(fontWeight: FontWeight.w900);

  // Font Size Variations
  TextStyle get xs => copyWith(fontSize: 10);
  TextStyle get sm => copyWith(fontSize: 12);
  TextStyle get base => copyWith(fontSize: 14);
  TextStyle get lg => copyWith(fontSize: 16);
  TextStyle get xl => copyWith(fontSize: 18);
  TextStyle get xl2 => copyWith(fontSize: 20);
  TextStyle get xl3 => copyWith(fontSize: 24);
  TextStyle get xl4 => copyWith(fontSize: 28);
  TextStyle get xl5 => copyWith(fontSize: 32);
  TextStyle get xl6 => copyWith(fontSize: 36);

  // Letter Spacing
  TextStyle get tighter => copyWith(letterSpacing: -0.5);
  TextStyle get tight => copyWith(letterSpacing: -0.25);
  TextStyle get wide => copyWith(letterSpacing: 0.5);
  TextStyle get wider => copyWith(letterSpacing: 1.0);
  TextStyle get widest => copyWith(letterSpacing: 1.5);

  // Line Height
  TextStyle get leading3 => copyWith(height: 0.75);
  TextStyle get leading4 => copyWith(height: 1.0);
  TextStyle get leading5 => copyWith(height: 1.25);
  TextStyle get leading6 => copyWith(height: 1.5);
  TextStyle get leading7 => copyWith(height: 1.75);
  TextStyle get leading8 => copyWith(height: 2.0);
  TextStyle get leading9 => copyWith(height: 2.25);
  TextStyle get leading10 => copyWith(height: 2.5);

  // Text Decorations
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);
  TextStyle get noDecoration => copyWith(decoration: TextDecoration.none);

  // Text Transform (using custom implementation)
  TextStyle get uppercase =>
      this; // Note: Flutter doesn't have built-in text transform
  TextStyle get lowercase => this;
  TextStyle get capitalize => this;

  // Font Styles
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get upright => copyWith(fontStyle: FontStyle.normal);

  // Color Variations (requires context)
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withOpacity(double opacity) =>
      copyWith(color: color?.withValues(alpha: opacity));

  // Size Variations
  TextStyle withSize(double size) => copyWith(fontSize: size);
  TextStyle scale(double factor) =>
      copyWith(fontSize: (fontSize ?? 14) * factor);

  // Responsive Font Sizes
  TextStyle responsive(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    double responsiveSize;

    if (screenWidth < 600) {
      responsiveSize = mobile ?? fontSize ?? 14;
    } else if (screenWidth < 1024) {
      responsiveSize = tablet ?? fontSize ?? 14;
    } else {
      responsiveSize = desktop ?? fontSize ?? 14;
    }

    return copyWith(fontSize: responsiveSize);
  }

  // Shadow Effects
  TextStyle withShadow({
    Color color = Colors.black54,
    double blurRadius = 2.0,
    Offset offset = const Offset(1, 1),
  }) => copyWith(
    shadows: [Shadow(color: color, blurRadius: blurRadius, offset: offset)],
  );
  TextStyle get styleItemCategory =>
      copyWith(fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle withGlow({Color color = Colors.white, double blurRadius = 10.0}) =>
      copyWith(
        shadows: [
          Shadow(color: color, blurRadius: blurRadius, offset: Offset.zero),
        ],
      );

  // Multiple Shadows
  TextStyle withMultipleShadows(List<Shadow> shadows) =>
      copyWith(shadows: shadows);

  // Font Family Shortcuts
  TextStyle get roboto => copyWith(fontFamily: 'Roboto');
  TextStyle get openSans => copyWith(fontFamily: 'Open Sans');
  TextStyle get lato => copyWith(fontFamily: 'Lato');
  TextStyle get montserrat => copyWith(fontFamily: 'Montserrat');
  TextStyle get poppins => copyWith(fontFamily: 'Poppins');
  TextStyle get nunito => copyWith(fontFamily: 'Nunito');
  TextStyle get sourceSansPro => copyWith(fontFamily: 'Source Sans Pro');
  TextStyle get raleway => copyWith(fontFamily: 'Raleway');

  // Arabic Fonts
  TextStyle get cairo => copyWith(fontFamily: 'Cairo');
  TextStyle get tajawal => copyWith(fontFamily: 'Tajawal');
  TextStyle get amiri => copyWith(fontFamily: 'Amiri');
  TextStyle get scheherazade => copyWith(fontFamily: 'Scheherazade');

  // Monospace Fonts
  TextStyle get mono => copyWith(fontFamily: 'monospace');
  TextStyle get courierNew => copyWith(fontFamily: 'Courier New');
  TextStyle get sourceCodePro => copyWith(fontFamily: 'Source Code Pro');

  // Serif Fonts
  TextStyle get serif => copyWith(fontFamily: 'serif');
  TextStyle get timesNewRoman => copyWith(fontFamily: 'Times New Roman');
  TextStyle get georgia => copyWith(fontFamily: 'Georgia');

  // Display Styles
  TextStyle get display => copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25,
  );

  TextStyle get headline =>
      copyWith(fontSize: 32, fontWeight: FontWeight.w400, height: 1.25);

  TextStyle get title =>
      copyWith(fontSize: 22, fontWeight: FontWeight.w400, height: 1.27);

  TextStyle get body => copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
  );

  TextStyle get label => copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
  );
  // إضافة الدعم للغة العربية
  TextStyle get arabicOptimized => copyWith(letterSpacing: 0, height: 1.6);

  // إضافة textAlign (كانت ناقصة)
  TextStyle withTextAlign(TextAlign align) => copyWith();

  // إضافة maxLines (كانت ناقصة)
  TextStyle withMaxLines(int maxLines) => copyWith();

  // إضافة overflow (كانت ناقصة)
  TextStyle withOverflow(TextOverflow overflow) => copyWith(overflow: overflow);
}

/// Predefined Text Styles
class AppTextStyles {
  // Display Styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
  );

  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.29,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  // Custom Styles
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );

  // Arabic Text Styles
  static const TextStyle arabicDisplay = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: 'Cairo',
    height: 1.4,
  );

  static const TextStyle arabicBody = TextStyle(
    fontSize: 16,
    fontFamily: 'Tajawal',
    height: 1.6,
  );

  // Code Styles
  static const TextStyle code = TextStyle(
    fontSize: 14,
    fontFamily: 'monospace',
    backgroundColor: Color(0xFFF5F5F5),
  );

  static const TextStyle codeBlock = TextStyle(
    fontSize: 14,
    fontFamily: 'Source Code Pro',
    height: 1.5,
  );
}
