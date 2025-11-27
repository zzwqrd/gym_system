import 'package:flutter/material.dart';

// Text Style Extensions on BuildContext
extension AppTextStyles on BuildContext {
  // Display Styles (Extra Large)
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;

  // Headlines
  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;

  // Titles
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;

  // Body Text
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;

  // Labels
  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;
  TextStyle get labelMedium => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;
}

// Sizing Extensions on BuildContext
extension ContextSizing on BuildContext {
  // Screen Dimensions
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenDiagonal => MediaQuery.of(this).size.shortestSide;

  // Safe Area
  EdgeInsets get safeArea => MediaQuery.of(this).padding;
  double get safeAreaTop => MediaQuery.of(this).padding.top;
  double get safeAreaBottom => MediaQuery.of(this).padding.bottom;
  double get safeAreaLeft => MediaQuery.of(this).padding.left;
  double get safeAreaRight => MediaQuery.of(this).padding.right;

  // Status and Navigation Bars
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get navigationBarHeight => MediaQuery.of(this).padding.bottom;
  double get appBarHeight => kToolbarHeight;

  // Keyboard
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;
  bool get isKeyboardVisible => keyboardHeight > 0;

  // Device Orientation
  Orientation get orientation => MediaQuery.of(this).orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // Device Type Detection
  bool get isPhone => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;
  bool get isSmallPhone => screenWidth < 360;
  bool get isLargePhone => screenWidth >= 360 && screenWidth < 600;

  // Device Density
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;
  double get textScaleFactor => MediaQuery.of(this).textScaler.scale(1);
}
