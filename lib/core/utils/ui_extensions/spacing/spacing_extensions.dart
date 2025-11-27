import 'package:flutter/material.dart';

extension SpacingExtensions on BuildContext {
  // Spacing System (Material Design 3)
  double get space0 => 0;
  double get space1 => 4;
  double get space2 => 8;
  double get space3 => 12;
  double get space4 => 16;
  double get space5 => 20;
  double get space6 => 24;
  double get space7 => 28;
  double get space8 => 32;
  double get space9 => 36;
  double get space10 => 40;
  double get space11 => 44;
  double get space12 => 48;
  double get space14 => 56;
  double get space16 => 64;
  double get space20 => 80;
  double get space24 => 96;
  double get space28 => 112;
  double get space32 => 128;

  // Legacy Spacing
  double get xs => space1;
  double get sm => space2;
  double get md => space4;
  double get lg => space6;
  double get xl => space8;
  double get xxl => space12;
  double get xxxl => space16;
}

class AppSizes {
  // Spacing Scale
  static const double space0 = 0;
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 20;
  static const double space6 = 24;
  static const double space8 = 32;
  static const double space10 = 40;
  static const double space12 = 48;
  static const double space16 = 64;
  static const double space20 = 80;
  static const double space24 = 96;

  // Icon Sizes
  static const double iconXS = 12;
  static const double iconSM = 16;
  static const double iconMD = 20;
  static const double iconLG = 24;
  static const double iconXL = 32;
  static const double iconXXL = 48;

  // Avatar Sizes
  static const double avatarXS = 24;
  static const double avatarSM = 32;
  static const double avatarMD = 40;
  static const double avatarLG = 48;
  static const double avatarXL = 64;
  static const double avatarXXL = 96;

  // Button Heights
  static const double buttonSM = 32;
  static const double buttonMD = 40;
  static const double buttonLG = 48;
  static const double buttonXL = 56;
}
