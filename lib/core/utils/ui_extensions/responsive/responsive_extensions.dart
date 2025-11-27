import 'package:flutter/material.dart';
import '../context/context_extensions.dart';

extension ResponsiveExtensions on BuildContext {
  // Responsive Breakpoints
  bool get isXSmall => screenWidth < 576;
  bool get isSmall => screenWidth >= 576 && screenWidth < 768;
  bool get isMedium => screenWidth >= 768 && screenWidth < 992;
  bool get isLarge => screenWidth >= 992 && screenWidth < 1200;
  bool get isXLarge => screenWidth >= 1200;

  // Responsive Values
  T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }

  double responsiveValue({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsive<double>(mobile: mobile, tablet: tablet, desktop: desktop);
  }
}

extension WidgetResponsive on Widget {
  // Responsive Sizing
  Widget responsive(
    BuildContext context, {
    double? mobileWidth,
    double? tabletWidth,
    double? desktopWidth,
    double? mobileHeight,
    double? tabletHeight,
    double? desktopHeight,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    double? width;
    double? height;

    if (screenWidth < 600) {
      width = mobileWidth;
      height = mobileHeight;
    } else if (screenWidth < 1024) {
      width = tabletWidth ?? mobileWidth;
      height = tabletHeight ?? mobileHeight;
    } else {
      width = desktopWidth ?? tabletWidth ?? mobileWidth;
      height = desktopHeight ?? tabletHeight ?? mobileHeight;
    }

    return SizedBox(width: width, height: height, child: this);
  }
}
