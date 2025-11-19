import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  /// Creates a vertical space (height)
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  /// Creates a horizontal space (width)
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}

extension PredefinedSizedBoxExtension on BuildContext {
  /// Predefined vertical spaces
  SizedBox get smallVertical => const SizedBox(height: 8);
  SizedBox get mediumVertical => const SizedBox(height: 16);
  SizedBox get largeVertical => const SizedBox(height: 32);

  /// Predefined horizontal spaces
  SizedBox get smallHorizontal => const SizedBox(width: 8);
  SizedBox get mediumHorizontal => const SizedBox(width: 16);
  SizedBox get largeHorizontal => const SizedBox(width: 32);

  /// Dynamic vertical space based on screen height
  SizedBox dynamicVertical(double percentage) =>
      SizedBox(height: MediaQuery.of(this).size.height * percentage);

  /// Dynamic horizontal space based on screen width
  SizedBox dynamicHorizontal(double percentage) =>
      SizedBox(width: MediaQuery.of(this).size.width * percentage);
}
