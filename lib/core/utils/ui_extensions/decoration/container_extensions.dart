import 'package:flutter/material.dart';

extension ContainerExtensions on Widget {
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
}
