// Sizing Extensions
import 'package:flutter/material.dart';

extension AppSizing on BuildContext {
  // Screen Dimensions
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  // Safe Area
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;
  double get safeAreaTop => MediaQuery.of(this).padding.top;
  double get safeAreaBottom => MediaQuery.of(this).padding.bottom;

  // Responsive Breakpoints
  bool get isSmallMobile => screenWidth < 360;
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;
  bool get isLandscape => screenWidth > screenHeight;
  bool get isPortrait => screenHeight > screenWidth;

  // Device Type
  bool get isPhone => isMobile && !isTablet;
  bool get isTabletPortrait => isTablet && isPortrait;
  bool get isTabletLandscape => isTablet && isLandscape;

  // Spacing System (Material Design 3)
  double get spacing0 => 0.0;
  double get spacing1 => 4.0;
  double get spacing2 => 8.0;
  double get spacing3 => 12.0;
  double get spacing4 => 16.0;
  double get spacing5 => 20.0;
  double get spacing6 => 24.0;
  double get spacing7 => 28.0;
  double get spacing8 => 32.0;
  double get spacing9 => 36.0;
  double get spacing10 => 40.0;
  double get spacing12 => 48.0;
  double get spacing16 => 64.0;
  double get spacing20 => 80.0;
  double get spacing24 => 96.0;

  // Legacy Spacing (for backward compatibility)
  double get xs => spacing1;
  double get sm => spacing2;
  double get md => spacing4;
  double get lg => spacing6;
  double get xl => spacing8;
  double get xxl => spacing12;
  double get xxxl => spacing16;

  // Responsive Spacing
  double get responsiveXS => isMobile ? spacing1 : spacing2;
  double get responsiveSM => isMobile ? spacing2 : spacing3;
  double get responsiveMD => isMobile ? spacing4 : spacing5;
  double get responsiveLG => isMobile ? spacing6 : spacing8;
  double get responsiveXL => isMobile ? spacing8 : spacing10;

  // Border Radius System
  BorderRadius get radius0 => BorderRadius.circular(0);
  BorderRadius get radius1 => BorderRadius.circular(4);
  BorderRadius get radius2 => BorderRadius.circular(8);
  BorderRadius get radius3 => BorderRadius.circular(12);
  BorderRadius get radius4 => BorderRadius.circular(16);
  BorderRadius get radius5 => BorderRadius.circular(20);
  BorderRadius get radius6 => BorderRadius.circular(24);
  BorderRadius get radius8 => BorderRadius.circular(32);
  BorderRadius get radiusFull => BorderRadius.circular(9999);

  // Legacy Radius
  BorderRadius get radiusXS => radius1;
  BorderRadius get radiusSM => radius2;
  BorderRadius get radiusMD => radius3;
  BorderRadius get radiusLG => radius4;
  BorderRadius get radiusXL => radius5;
  BorderRadius get radiusXXL => radius6;
  BorderRadius get radiusRounded => radiusFull;

  // Special Radius
  BorderRadius get radiusTopOnly => BorderRadius.only(
    topLeft: Radius.circular(radius3.topLeft.x),
    topRight: Radius.circular(radius3.topRight.x),
  );

  BorderRadius get radiusBottomOnly => BorderRadius.only(
    bottomLeft: Radius.circular(radius3.bottomLeft.x),
    bottomRight: Radius.circular(radius3.bottomRight.x),
  );

  BorderRadius get radiusLeftOnly => BorderRadius.only(
    topLeft: Radius.circular(radius3.topLeft.x),
    bottomLeft: Radius.circular(radius3.bottomLeft.x),
  );

  BorderRadius get radiusRightOnly => BorderRadius.only(
    topRight: Radius.circular(radius3.topRight.x),
    bottomRight: Radius.circular(radius3.bottomRight.x),
  );

  // Icon Sizes
  double get icon12 => 12.0;
  double get icon16 => 16.0;
  double get icon20 => 20.0;
  double get icon24 => 24.0;
  double get icon28 => 28.0;
  double get icon32 => 32.0;
  double get icon36 => 36.0;
  double get icon40 => 40.0;
  double get icon48 => 48.0;
  double get icon56 => 56.0;
  double get icon64 => 64.0;

  // Legacy Icon Sizes
  double get iconXS => icon16;
  double get iconSM => icon20;
  double get iconMD => icon24;
  double get iconLG => icon32;
  double get iconXL => icon48;
  double get iconXXL => icon64;

  // Avatar Sizes
  double get avatar24 => 24.0;
  double get avatar32 => 32.0;
  double get avatar40 => 40.0;
  double get avatar48 => 48.0;
  double get avatar56 => 56.0;
  double get avatar64 => 64.0;
  double get avatar80 => 80.0;
  double get avatar96 => 96.0;
  double get avatar128 => 128.0;

  // Legacy Avatar Sizes
  double get avatarSM => avatar32;
  double get avatarMD => avatar48;
  double get avatarLG => avatar64;
  double get avatarXL => avatar96;

  // Button Heights
  double get buttonSmall => 32.0;
  double get buttonMedium => 40.0;
  double get buttonLarge => 48.0;
  double get buttonExtraLarge => 56.0;

  // Input Heights
  double get inputSmall => 32.0;
  double get inputMedium => 40.0;
  double get inputLarge => 48.0;

  // Elevation System
  double get elevation0 => 0.0;
  double get elevation1 => 1.0;
  double get elevation2 => 2.0;
  double get elevation3 => 3.0;
  double get elevation4 => 4.0;
  double get elevation6 => 6.0;
  double get elevation8 => 8.0;
  double get elevation12 => 12.0;
  double get elevation16 => 16.0;
  double get elevation24 => 24.0;
}
