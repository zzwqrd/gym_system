import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  // Elevation (Material Design)
  Widget elevation(double elevation) =>
      Material(elevation: elevation, child: this);

  Widget get elevation0 => elevation(0);
  Widget get elevation1 => elevation(1);
  Widget get elevation2 => elevation(2);
  Widget get elevation3 => elevation(3);
  Widget get elevation4 => elevation(4);
  Widget get elevation6 => elevation(6);
  Widget get elevation8 => elevation(8);
  Widget get elevation12 => elevation(12);
  Widget get elevation16 => elevation(16);
  Widget get elevation24 => elevation(24);

  // Opacity
  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);
  Widget get opacity0 => opacity(0.0);
  Widget get opacity25 => opacity(0.25);
  Widget get opacity50 => opacity(0.5);
  Widget get opacity75 => opacity(0.75);
  Widget get opacity100 => opacity(1.0);

  // Visibility
  Widget visible(bool isVisible) => Visibility(visible: isVisible, child: this);
  Widget get invisible => visible(false);
  Widget get hidden => Visibility(child: this);

  // Clipping
  Widget clipRect() => ClipRect(child: this);
  Widget clipOval() => ClipOval(child: this);
  Widget clipPath(CustomClipper<Path> clipper) =>
      ClipPath(clipper: clipper, child: this);

  // Transforms
  Widget rotate(double angle) => Transform.rotate(angle: angle, child: this);
  Widget scale(double scale) => Transform.scale(scale: scale, child: this);
  Widget translate({double x = 0, double y = 0}) =>
      Transform.translate(offset: Offset(x, y), child: this);

  Widget get rotate45 => rotate(0.785398); // 45 degrees in radians
  Widget get rotate90 => rotate(1.570796); // 90 degrees in radians
  Widget get rotate180 => rotate(3.141593); // 180 degrees in radians
  Widget get rotate270 => rotate(4.712389); // 270 degrees in radians

  Widget get scaleHalf => scale(0.5);
  Widget get scale75 => scale(0.75);
  Widget get scale110 => scale(1.1);
  Widget get scale125 => scale(1.25);
  Widget get scale150 => scale(1.5);
  Widget get scale200 => scale(2.0);

  // Flex Properties
  Widget flex([int flex = 1]) => Flexible(flex: flex, child: this);
  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);
  Widget get flexNone => this;
  Widget get flex1 => flex(1);
  Widget get flex2 => flex(2);
  Widget get flex3 => flex(3);
  Widget get flex4 => flex(4);
  Widget get flex5 => flex(5);

  // Card Styles
  Widget card({
    Color? color,
    double? elevation,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    Clip? clipBehavior,
  }) => Card(
    color: color,
    elevation: elevation ?? 2,
    margin: margin,
    clipBehavior: clipBehavior,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
    ),
    child: this,
  );

  Widget get cardFlat => card(elevation: 0);
  Widget get cardRaised => card(elevation: 8);

  // Material Styles
  Widget material({
    MaterialType type = MaterialType.canvas,
    double elevation = 0,
    Color? color,
    Color? shadowColor,
    Color? surfaceTintColor,
    TextStyle? textStyle,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shape,
    bool borderOnForeground = true,
    Clip clipBehavior = Clip.none,
    Duration animationDuration = kThemeChangeDuration,
  }) => Material(
    type: type,
    elevation: elevation,
    color: color,
    shadowColor: shadowColor,
    surfaceTintColor: surfaceTintColor,
    textStyle: textStyle,
    borderRadius: borderRadius,
    shape: shape,
    borderOnForeground: borderOnForeground,
    clipBehavior: clipBehavior,
    animationDuration: animationDuration,
    child: this,
  );

  // Ink Effects
  Widget inkWell({
    VoidCallback? onTap,
    VoidCallback? onDoubleTap,
    VoidCallback? onLongPress,
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
    Color? hoverColor,
    Color? focusColor,
  }) => InkWell(
    onTap: onTap,
    onDoubleTap: onDoubleTap,
    onLongPress: onLongPress,
    borderRadius: borderRadius,
    splashColor: splashColor,
    highlightColor: highlightColor,
    hoverColor: hoverColor,
    focusColor: focusColor,
    child: this,
  );
}
