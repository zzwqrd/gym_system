import 'package:flutter/material.dart';
import 'package:gym_system/core/routes/app_routes_fun.dart';
import 'package:gym_system/core/ui/ui_extensions/color_extensions.dart';

class AppStyles {
  /// Large Text Style
  static TextStyle get largeText => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: navigatorKey.currentContext!.onWarningContainer,
  );

  /// Medium Text Style
  static TextStyle get mediumText => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: navigatorKey.currentContext!.onWarningContainer,
  );

  /// Small Text Style
  static TextStyle get smallText => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.telegram,
  );

  /// Input Decoration Theme
  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelStyle: mediumText.copyWith(
      fontSize: 14,
      color: navigatorKey.currentContext!.onSecondary,
    ),
    hintStyle: smallText.copyWith(
      fontSize: 12,
      color: navigatorKey.currentContext!.onSecondary,
    ),
    fillColor: navigatorKey.currentContext!.inverseSurface,
    filled: true,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: navigatorKey.currentContext!.inverseSurface,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: navigatorKey.currentContext!.onWarningContainer,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: navigatorKey.currentContext!.onWarningContainer,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: navigatorKey.currentContext!.onWarningContainer,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: navigatorKey.currentContext!.onWarningContainer,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: navigatorKey.currentContext!.onWarningContainer,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
  );
}
