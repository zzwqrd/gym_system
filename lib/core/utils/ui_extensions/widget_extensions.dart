import 'package:flutter/material.dart';

/// Comprehensive Box and Container Extensions for Flutter
extension BoxExtensions on Widget {
  // Basic Container Wrapping
  Widget container({
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Clip clipBehavior = Clip.none,
  }) => Container(
    key: key,
    alignment: alignment,
    padding: padding,
    color: color,
    decoration: decoration,
    foregroundDecoration: foregroundDecoration,
    width: width,
    height: height,
    constraints: constraints,
    margin: margin,
    transform: transform,
    transformAlignment: transformAlignment,
    clipBehavior: clipBehavior,
    child: this,
  );

  // Background Colors
  Widget backgroundColor(Color color) => Container(color: color, child: this);
  Widget get bgTransparent => backgroundColor(Colors.transparent);
  Widget get bgWhite => backgroundColor(Colors.white);
  Widget get bgBlack => backgroundColor(Colors.black);
  Widget get bgGrey => backgroundColor(Colors.grey);
  Widget get bgRed => backgroundColor(Colors.red);
  Widget get bgBlue => backgroundColor(Colors.blue);
  Widget get bgGreen => backgroundColor(Colors.green);
  Widget get bgYellow => backgroundColor(Colors.yellow);
  Widget get bgOrange => backgroundColor(Colors.orange);
  Widget get bgPurple => backgroundColor(Colors.purple);
  Widget get bgPink => backgroundColor(Colors.pink);
  Widget get bgTeal => backgroundColor(Colors.teal);
  Widget get bgIndigo => backgroundColor(Colors.indigo);
  Widget get bgCyan => backgroundColor(Colors.cyan);
  Widget get bgAmber => backgroundColor(Colors.amber);
  Widget get bgLime => backgroundColor(Colors.lime);
  Widget get bgBrown => backgroundColor(Colors.brown);

  // Border Radius
  Widget borderRadius(BorderRadius radius) =>
      ClipRRect(borderRadius: radius, child: this);

  Widget get rounded => borderRadius(BorderRadius.circular(4));
  Widget get roundedSM => borderRadius(BorderRadius.circular(2));
  Widget get roundedMD => borderRadius(BorderRadius.circular(6));
  Widget get roundedLG => borderRadius(BorderRadius.circular(8));
  Widget get roundedXL => borderRadius(BorderRadius.circular(12));
  Widget get rounded2XL => borderRadius(BorderRadius.circular(16));
  Widget get rounded3XL => borderRadius(BorderRadius.circular(24));
  Widget get roundedFull => borderRadius(BorderRadius.circular(9999));

  Widget get roundedT => ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
    ),
    child: this,
  );

  Widget get roundedB => ClipRRect(
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8),
    ),
    child: this,
  );

  Widget get roundedL => ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(8),
      bottomLeft: Radius.circular(8),
    ),
    child: this,
  );

  Widget get roundedR => ClipRRect(
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(8),
      bottomRight: Radius.circular(8),
    ),
    child: this,
  );

  // Borders
  Widget border({
    Color color = Colors.grey,
    double width = 1,
    BorderRadius? borderRadius,
  }) => Container(
    decoration: BoxDecoration(
      border: Border.all(color: color, width: width),
      borderRadius: borderRadius,
    ),
    child: this,
  );

  Widget get border1 => border(width: 1);
  Widget get border2 => border(width: 2);
  Widget get border4 => border(width: 4);
  Widget get border8 => border(width: 8);

  Widget borderColor(Color color) => border(color: color);
  Widget get borderGrey => borderColor(Colors.grey);
  Widget get borderBlack => borderColor(Colors.black);
  Widget get borderWhite => borderColor(Colors.white);
  Widget get borderRed => borderColor(Colors.red);
  Widget get borderBlue => borderColor(Colors.blue);
  Widget get borderGreen => borderColor(Colors.green);

  Widget borderT({Color color = Colors.grey, double width = 1}) => Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: color, width: width),
      ),
    ),
    child: this,
  );

  Widget borderB({Color color = Colors.grey, double width = 1}) => Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: color, width: width),
      ),
    ),
    child: this,
  );

  Widget borderL({Color color = Colors.grey, double width = 1}) => Container(
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: color, width: width),
      ),
    ),
    child: this,
  );

  Widget borderR({Color color = Colors.grey, double width = 1}) => Container(
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(color: color, width: width),
      ),
    ),
    child: this,
  );

  // Shadows
  Widget shadow({
    Color color = Colors.black,
    double opacity = 0.1,
    double blurRadius = 8,
    Offset offset = const Offset(0, 2),
    BorderRadius? borderRadius,
  }) => Container(
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: opacity),
          blurRadius: blurRadius,
          offset: offset,
        ),
      ],
    ),
    child: this,
  );

  Widget get shadowSM => shadow(blurRadius: 2, offset: const Offset(0, 1));
  Widget get shadowMD => shadow(blurRadius: 4, offset: const Offset(0, 2));
  Widget get shadowLG => shadow(blurRadius: 8, offset: const Offset(0, 4));
  Widget get shadowXL => shadow(blurRadius: 16, offset: const Offset(0, 8));
  Widget get shadow2XL => shadow(blurRadius: 24, offset: const Offset(0, 12));
  Widget get shadowInner => shadow(blurRadius: 4, offset: const Offset(0, -2));

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

  // Gradients
  Widget gradient(Gradient gradient) => Container(
    decoration: BoxDecoration(gradient: gradient),
    child: this,
  );

  Widget linearGradient({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    List<double>? stops,
  }) => gradient(
    LinearGradient(colors: colors, begin: begin, end: end, stops: stops),
  );

  Widget radialGradient({
    required List<Color> colors,
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    List<double>? stops,
  }) => gradient(
    RadialGradient(
      colors: colors,
      center: center,
      radius: radius,
      stops: stops,
    ),
  );

  Widget sweepGradient({
    required List<Color> colors,
    AlignmentGeometry center = Alignment.center,
    double startAngle = 0.0,
    double endAngle = 6.28,
    List<double>? stops,
  }) => gradient(
    SweepGradient(
      colors: colors,
      center: center,
      startAngle: startAngle,
      endAngle: endAngle,
      stops: stops,
    ),
  );

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

  // Alignment
  Widget align(AlignmentGeometry alignment) =>
      Align(alignment: alignment, child: this);
  Widget get center => Center(child: this);
  Widget get centerLeft => align(Alignment.centerLeft);
  Widget get centerRight => align(Alignment.centerRight);
  Widget get topCenter => align(Alignment.topCenter);
  Widget get topLeft => align(Alignment.topLeft);
  Widget get topRight => align(Alignment.topRight);
  Widget get bottomCenter => align(Alignment.bottomCenter);
  Widget get bottomLeft => align(Alignment.bottomLeft);
  Widget get bottomRight => align(Alignment.bottomRight);

  // Positioning
  Widget positioned({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? width,
    double? height,
  }) => Positioned(
    top: top,
    bottom: bottom,
    left: left,
    right: right,
    width: width,
    height: height,
    child: this,
  );

  Widget get positionedFill => Positioned.fill(child: this);

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
