import 'package:flutter/material.dart';

extension AlignmentExtensions on Widget {
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
}
