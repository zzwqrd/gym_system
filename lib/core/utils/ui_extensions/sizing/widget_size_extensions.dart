import 'package:flutter/material.dart';

extension WidgetSizeExtensions on Widget {
  // Sizing Extensions
  Widget sized({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: this);

  Widget square(double size) =>
      SizedBox(width: size, height: size, child: this);

  Widget width(double width) => SizedBox(width: width, child: this);
  Widget height(double height) => SizedBox(height: height, child: this);

  Widget intrinsicWidth() => IntrinsicWidth(child: this);
  Widget intrinsicHeight() => IntrinsicHeight(child: this);

  Widget constrainedBox({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) => ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: minWidth ?? 0,
      maxWidth: maxWidth ?? double.infinity,
      minHeight: minHeight ?? 0,
      maxHeight: maxHeight ?? double.infinity,
    ),
    child: this,
  );
}
