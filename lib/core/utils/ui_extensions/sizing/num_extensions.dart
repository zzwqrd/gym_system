import 'package:flutter/material.dart';

extension NumExtensions on num {
  // Spacing (SizedBox)
  SizedBox get verticalSpace => SizedBox(height: toDouble());
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  // Padding (EdgeInsets)
  EdgeInsets get p => EdgeInsets.all(toDouble());
  EdgeInsets get px => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get py => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get pt => EdgeInsets.only(top: toDouble());
  EdgeInsets get pb => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get pl => EdgeInsets.only(left: toDouble());
  EdgeInsets get pr => EdgeInsets.only(right: toDouble());

  // Radius (BorderRadius)
  BorderRadius get r => BorderRadius.circular(toDouble());
  BorderRadius get rt => BorderRadius.only(
    topLeft: Radius.circular(toDouble()),
    topRight: Radius.circular(toDouble()),
  );
  BorderRadius get rb => BorderRadius.only(
    bottomLeft: Radius.circular(toDouble()),
    bottomRight: Radius.circular(toDouble()),
  );
  BorderRadius get rl => BorderRadius.only(
    topLeft: Radius.circular(toDouble()),
    bottomLeft: Radius.circular(toDouble()),
  );
  BorderRadius get rr => BorderRadius.only(
    topRight: Radius.circular(toDouble()),
    bottomRight: Radius.circular(toDouble()),
  );

  // Duration
  Duration get ms => Duration(milliseconds: toInt());
  Duration get sec => Duration(seconds: toInt());
  Duration get min => Duration(minutes: toInt());

  // Size & Offset
  Size get size => Size(toDouble(), toDouble());
  Offset get offset => Offset(toDouble(), toDouble());
}
