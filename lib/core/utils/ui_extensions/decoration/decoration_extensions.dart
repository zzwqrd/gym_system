import 'package:flutter/material.dart';
import 'package:gym_system/core/routes/app_routes_fun.dart';

import '../extensions_init.dart';

// Box Decoration Extensions
extension AppDecorations on BuildContext {
  // Card Decorations
  BoxDecoration get cardDecoration => BoxDecoration(
    color: navigatorKey.currentContext!.surfaceColor,
    borderRadius: navigatorKey.currentContext!.radiusMD,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  BoxDecoration get elevatedCardDecoration => BoxDecoration(
    color: navigatorKey.currentContext!.surfaceColor,
    borderRadius: navigatorKey.currentContext!.radiusMD,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ],
  );
  // BoxDecoration(color: bgColor, borderRadius: 15.r)
  BoxDecoration categoryDecoration(Color color) =>
      BoxDecoration(color: color, borderRadius: 15.r);

  BoxDecoration boxDecoration({required Color color}) => BoxDecoration(
    color: color,
    borderRadius: navigatorKey.currentContext!.radiusMD,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
  // Button Decorations
  BoxDecoration get primaryButtonDecoration => BoxDecoration(
    gradient: navigatorKey.currentContext!.primaryGradient,
    borderRadius: navigatorKey.currentContext!.radiusSM,
    boxShadow: [
      BoxShadow(
        color: navigatorKey.currentContext!.primaryColor.withValues(alpha: 0.3),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  BoxDecoration get secondaryButtonDecoration => BoxDecoration(
    border: Border.all(color: navigatorKey.currentContext!.primaryColor),
    borderRadius: navigatorKey.currentContext!.radiusSM,
    color: Colors.transparent,
  );

  // Input Decorations
  InputDecoration get inputDecoration => InputDecoration(
    filled: true,
    fillColor: navigatorKey.currentContext!.backgroundColor,
    border: OutlineInputBorder(
      borderRadius: navigatorKey.currentContext!.radiusSM,
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: navigatorKey.currentContext!.radiusSM,
      borderSide: BorderSide(
        color: navigatorKey.currentContext!.primaryColor,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: navigatorKey.currentContext!.radiusSM,
      borderSide: BorderSide(
        color: navigatorKey.currentContext!.error,
        width: 1,
      ),
    ),
    contentPadding: navigatorKey.currentContext!.paddingGeometry,
  );
}

extension ColorDecoration on Color {
  BoxDecoration get circleDecoration =>
      BoxDecoration(color: this, shape: BoxShape.circle);
}
