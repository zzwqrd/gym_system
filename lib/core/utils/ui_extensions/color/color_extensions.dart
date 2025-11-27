import 'package:flutter/material.dart';

/// Comprehensive Color Extensions for Flutter
extension ColorExtensions on dynamic {
  // Primary Colors
  Color get primaryColor => const Color(0xFF2196F3);
  Color get primaryLight => const Color(0xFF64B5F6);
  Color get primaryDark => const Color(0xFF1976D2);

  // Secondary Colors
  Color get secondaryColor => const Color(0xFFFF9800);
  Color get secondaryLight => const Color(0xFFFFB74D);
  Color get secondaryDark => const Color(0xFFF57C00);

  // Accent Colors
  Color get accentColor => const Color(0xFF9C27B0);
  Color get accentLight => const Color(0xFFBA68C8);
  Color get accentDark => const Color(0xFF7B1FA2);

  // Neutral Colors
  Color get backgroundColor => const Color(0xFFF5F5F5);
  Color get surfaceColor => Colors.white;
  Color get cardColor => Colors.white;
  Color get dividerColor => const Color(0xFFE0E0E0);
  Color get scaffoldColor => const Color(0xFFFAFAFA);

  // Text Colors
  Color get textPrimary => const Color(0xFF212121);
  Color get textSecondary => const Color(0xFF757575);
  Color get textHint => const Color(0xFFBDBDBD);
  Color get textDisabled => const Color(0xFF9E9E9E);
  Color get textOnPrimary => Colors.white;
  Color get textOnSecondary => Colors.white;

  // Status Colors
  Color get successColor => const Color(0xFF4CAF50);
  Color get successLight => const Color(0xFF81C784);
  Color get successDark => const Color(0xFF388E3C);

  Color get errorColor => const Color(0xFFF44336);
  Color get errorLight => const Color(0xFFE57373);
  Color get errorDark => const Color(0xFFD32F2F);

  Color get warningColor => const Color(0xFFFF9800);
  Color get warningLight => const Color(0xFFFFB74D);
  Color get warningDark => const Color(0xFFF57C00);

  Color get infoColor => const Color(0xFF2196F3);
  Color get infoLight => const Color(0xFF64B5F6);
  Color get infoDark => const Color(0xFF1976D2);

  // Gradient Colors
  LinearGradient get primaryGradient => LinearGradient(
    colors: [primaryColor, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get secondaryGradient => LinearGradient(
    colors: [secondaryColor, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get successGradient => LinearGradient(
    colors: [successColor, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get errorGradient => LinearGradient(
    colors: [errorColor, errorLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get warningGradient => LinearGradient(
    colors: [warningColor, warningLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get infoGradient => LinearGradient(
    colors: [infoColor, infoLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Special Gradients
  LinearGradient get sunsetGradient => const LinearGradient(
    colors: [Color(0xFFFF7043), Color(0xFFFFAB40)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get oceanGradient => const LinearGradient(
    colors: [Color(0xFF0277BD), Color(0xFF00BCD4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get forestGradient => const LinearGradient(
    colors: [Color(0xFF388E3C), Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  // Color Brightness and Contrast
  Color get onColor => computeLuminance() > 0.5 ? Colors.black : Colors.white;
  Color get onColorVariant =>
      computeLuminance() > 0.5 ? Colors.black87 : Colors.white70;

  bool get isDark => computeLuminance() < 0.5;
  bool get isLight => computeLuminance() >= 0.5;

  // Color Variations
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  Color saturate([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final saturation = (hsl.saturation + amount).clamp(0.0, 1.0);
    return hsl.withSaturation(saturation).toColor();
  }

  Color desaturate([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final saturation = (hsl.saturation - amount).clamp(0.0, 1.0);
    return hsl.withSaturation(saturation).toColor();
  }

  // Opacity Variations
  Color get transparent => withValues(alpha: 0.0);
  Color get semiTransparent => withValues(alpha: 0.5);
  Color get mostlyTransparent => withValues(alpha: 0.1);
  Color get slightlyTransparent => withValues(alpha: 0.9);

  // Material Design Opacity Levels
  Color get disabled => withValues(alpha: 0.38);
  Color get medium => withValues(alpha: 0.60);
  Color get high => withValues(alpha: 0.87);

  // Color Mixing
  Color mix(Color other, [double ratio = 0.5]) {
    return Color.lerp(this, other, ratio) ?? this;
  }

  // Complementary Colors
  Color get complement {
    final hsl = HSLColor.fromColor(this);
    final hue = (hsl.hue + 180) % 360;
    return hsl.withHue(hue).toColor();
  }

  // Analogous Colors
  List<Color> get analogous {
    final hsl = HSLColor.fromColor(this);
    return [
      hsl.withHue((hsl.hue - 30) % 360).toColor(),
      this,
      hsl.withHue((hsl.hue + 30) % 360).toColor(),
    ];
  }

  // Triadic Colors
  List<Color> get triadic {
    final hsl = HSLColor.fromColor(this);
    return [
      this,
      hsl.withHue((hsl.hue + 120) % 360).toColor(),
      hsl.withHue((hsl.hue + 240) % 360).toColor(),
    ];
  }

  // Monochromatic Palette
  List<Color> get monochromatic {
    return [darken(0.4), darken(0.2), this, lighten(0.2), lighten(0.4)];
  }

  // Hex String Conversion
  String get hex =>
      '#${toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
  String get hexWithAlpha => '#${toARGB32().toRadixString(16).padLeft(8, '0')}';

  // Material Design Tonal Palette
  List<Color> get tonalPalette {
    final hsl = HSLColor.fromColor(this);
    return List.generate(11, (index) {
      final lightness = (index * 0.1).clamp(0.0, 1.0);
      return hsl.withLightness(lightness).toColor();
    });
  }

  // Material You Dynamic Colors
  Color get surface => lighten(0.95);
  Color get surfaceVariant => lighten(0.85);
  Color get outline => darken(0.3);
  Color get shadow => Colors.black.withValues(alpha: 0.2);
  Color get scrim => Colors.black.withValues(alpha: 0.32);

  // Accessibility Colors
  Color get accessible =>
      computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
  Color get accessibleSecondary =>
      computeLuminance() > 0.5 ? Colors.black54 : Colors.white70;

  // State Colors
  Color get hover => lighten(0.04);
  Color get focus => lighten(0.08);
  Color get pressed => darken(0.08);
  Color get dragged => lighten(0.16);

  // Gradient Helpers
  LinearGradient toLinearGradient([
    Color? endColor,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  ]) {
    return LinearGradient(
      colors: [this, endColor ?? lighten(0.2)],
      begin: begin ?? Alignment.topLeft,
      end: end ?? Alignment.bottomRight,
    );
  }

  RadialGradient toRadialGradient([Color? endColor]) {
    return RadialGradient(colors: [this, endColor ?? lighten(0.2)]);
  }

  SweepGradient toSweepGradient([Color? endColor]) {
    return SweepGradient(colors: [this, endColor ?? lighten(0.2), this]);
  }
}

/// Context-based Color Extensions
extension ColorContext on BuildContext {
  // Material Design 3 Colors
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primary => colorScheme.primary;
  Color get onPrimary => colorScheme.onPrimary;
  Color get primaryContainer => colorScheme.primaryContainer;
  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;

  Color get secondary => colorScheme.secondary;
  Color get onSecondary => colorScheme.onSecondary;
  Color get secondaryContainer => colorScheme.secondaryContainer;
  Color get onSecondaryContainer => colorScheme.onSecondaryContainer;

  Color get tertiary => colorScheme.tertiary;
  Color get onTertiary => colorScheme.onTertiary;
  Color get tertiaryContainer => colorScheme.tertiaryContainer;
  Color get onTertiaryContainer => colorScheme.onTertiaryContainer;

  Color get error => colorScheme.error;
  Color get onError => colorScheme.onError;
  Color get errorContainer => colorScheme.errorContainer;
  Color get onErrorContainer => colorScheme.onErrorContainer;

  Color get surface => colorScheme.surface;
  Color get onSurface => colorScheme.onSurface;
  Color get surfaceVariant => colorScheme.surfaceContainerHighest;
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;

  Color get outline => colorScheme.outline;
  Color get outlineVariant => colorScheme.outlineVariant;
  Color get shadow => colorScheme.shadow;
  Color get scrim => colorScheme.scrim;
  Color get inverseSurface => colorScheme.inverseSurface;
  Color get onInverseSurface => colorScheme.onInverseSurface;
  Color get inversePrimary => colorScheme.inversePrimary;

  // Custom Semantic Colors
  Color get success => const Color(0xFF4CAF50);
  Color get onSuccess => Colors.white;
  Color get successContainer => const Color(0xFFE8F5E8);
  Color get onSuccessContainer => const Color(0xFF1B5E20);

  Color get warning => const Color(0xFFFF9800);
  Color get onWarning => Colors.white;
  Color get warningContainer => const Color(0xFFFFF3E0);
  Color get onWarningContainer => const Color(0xFFE65100);

  Color get info => const Color(0xFF2196F3);
  Color get onInfo => Colors.white;
  Color get infoContainer => const Color(0xFFE3F2FD);
  Color get onInfoContainer => const Color(0xFF0D47A1);

  // Background Colors
  Color get scaffoldBackground => Theme.of(this).scaffoldBackgroundColor;
  Color get cardColor => Theme.of(this).cardColor;
  Color get canvasColor => Theme.of(this).canvasColor;
  Color get dialogBackground =>
      Theme.of(this).dialogTheme.backgroundColor ??
      Theme.of(this).colorScheme.surface;

  // Text Colors
  Color get textPrimary =>
      Theme.of(this).textTheme.bodyLarge?.color ?? onSurface;
  Color get textSecondary => onSurface.withValues(alpha: 0.6);
  Color get textDisabled => onSurface.withValues(alpha: 0.38);
  Color get textHint => onSurface.withValues(alpha: 0.6);

  // Divider Colors
  Color get divider => Theme.of(this).dividerColor;
  Color get dividerLight => divider.withValues(alpha: 0.5);
  Color get dividerDark => divider.withValues(alpha: 0.8);

  // State Colors with Context
  Color get selectedColor => primary.withValues(alpha: 0.12);
  Color get hoverColor => onSurface.withValues(alpha: 0.04);
  Color get focusColor => onSurface.withValues(alpha: 0.12);
  Color get splashColor => onSurface.withValues(alpha: 0.12);
  Color get highlightColor => onSurface.withValues(alpha: 0.12);

  // Gradient Helpers
  LinearGradient get primaryGradient => LinearGradient(
    colors: [primary, primary.lighten(0.2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get secondaryGradient => LinearGradient(
    colors: [secondary, secondary.lighten(0.2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get surfaceGradient => LinearGradient(
    colors: [surface, surface.darken(0.05)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Additional Colors from AppColors
  Color get primaryLight => const Color(0xFF64B5F6);
  Color get primaryDark => const Color(0xFF1976D2);

  Color get secondaryLight => const Color(0xFFFFB74D);
  Color get secondaryDark => const Color(0xFFF57C00);

  Color get accentColor => const Color(0xFF9C27B0);
  Color get accentLight => const Color(0xFFBA68C8);
  Color get accentDark => const Color(0xFF7B1FA2);

  Color get backgroundColor => const Color(0xFFF5F5F5);
  Color get surfaceColor => Colors.white;
  Color get scaffoldColor => const Color(0xFFFAFAFA);

  Color get textOnPrimary => Colors.white;
  Color get textOnSecondary => Colors.white;

  Color get successColor => const Color(0xFF4CAF50);
  Color get successLight => const Color(0xFF81C784);
  Color get successDark => const Color(0xFF388E3C);

  Color get errorColor => const Color(0xFFF44336);
  Color get errorLight => const Color(0xFFE57373);
  Color get errorDark => const Color(0xFFD32F2F);

  Color get warningColor => const Color(0xFFFF9800);
  Color get warningLight => const Color(0xFFFFB74D);
  Color get warningDark => const Color(0xFFF57C00);

  Color get infoColor => const Color(0xFF2196F3);
  Color get infoLight => const Color(0xFF64B5F6);
  Color get infoDark => const Color(0xFF1976D2);

  // Additional Gradients
  LinearGradient get successGradient => LinearGradient(
    colors: [successColor, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get errorGradient => LinearGradient(
    colors: [errorColor, errorLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get warningGradient => LinearGradient(
    colors: [warningColor, warningLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get infoGradient => LinearGradient(
    colors: [infoColor, infoLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Special Gradients
  LinearGradient get sunsetGradient => const LinearGradient(
    colors: [Color(0xFFFF7043), Color(0xFFFFAB40)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get oceanGradient => const LinearGradient(
    colors: [Color(0xFF0277BD), Color(0xFF00BCD4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get forestGradient => const LinearGradient(
    colors: [Color(0xFF388E3C), Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// Predefined Color Palettes
class AppColors {
  // Material Design 3 Baseline Colors
  static const Color seed = Color(0xFF6750A4);

  // Brand Colors
  static const Color brandPrimary = Color(0xFF1976D2);
  static const Color brandSecondary = Color(0xFF388E3C);
  static const Color brandAccent = Color(0xFFFF5722);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Neutral Colors
  static const Color neutral10 = Color(0xFF1C1B1F);
  static const Color neutral20 = Color(0xFF313033);
  static const Color neutral30 = Color(0xFF484649);
  static const Color neutral40 = Color(0xFF605D62);
  static const Color neutral50 = Color(0xFF787579);
  static const Color neutral60 = Color(0xFF939094);
  static const Color neutral70 = Color(0xFFAEAAAE);
  static const Color neutral80 = Color(0xFFCAC4C9);
  static const Color neutral90 = Color(0xFFE6E0E5);
  static const Color neutral95 = Color(0xFFF4EFF4);
  static const Color neutral99 = Color(0xFFFFFBFE);

  // Social Media Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color linkedin = Color(0xFF0077B5);
  static const Color youtube = Color(0xFFFF0000);
  static const Color whatsapp = Color(0xFF25D366);
  static const Color telegram = Color(0xFF0088CC);

  // Status Colors
  static const Color online = Color(0xFF4CAF50);
  static const Color offline = Color(0xFF9E9E9E);
  static const Color away = Color(0xFFFF9800);
  static const Color busy = Color(0xFFF44336);
}
