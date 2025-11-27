import 'package:flutter/material.dart';
import 'package:gym_system/core/routes/app_routes_fun.dart';

import '../sizing/size_extensions.dart';

extension PaddingExtensions on dynamic {
  // Padding Extensions
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  Widget get p0 => paddingAll(0);
  Widget get p1 => paddingAll(4);
  Widget get p2 => paddingAll(8);
  Widget get p3 => paddingAll(12);
  Widget get p4 => paddingAll(16);
  Widget get p5 => paddingAll(20);
  Widget get p6 => paddingAll(24);
  Widget get p8 => paddingAll(32);
  Widget get p10 => paddingAll(40);
  Widget get p12 => paddingAll(48);

  Widget get px1 => paddingSymmetric(horizontal: 4);
  Widget get px2 => paddingSymmetric(horizontal: 8);
  Widget get px3 => paddingSymmetric(horizontal: 12);
  Widget get px4 => paddingSymmetric(horizontal: 16);
  Widget get px5 => paddingSymmetric(horizontal: 20);
  Widget get px6 => paddingSymmetric(horizontal: 24);
  Widget get px8 => paddingSymmetric(horizontal: 32);

  Widget get py1 => paddingSymmetric(vertical: 4);
  Widget get py2 => paddingSymmetric(vertical: 8);
  Widget get py3 => paddingSymmetric(vertical: 12);
  Widget get py4 => paddingSymmetric(vertical: 16);
  Widget get py5 => paddingSymmetric(vertical: 20);
  Widget get py6 => paddingSymmetric(vertical: 24);
  Widget get py8 => paddingSymmetric(vertical: 32);

  Widget get pt1 => paddingOnly(top: 4);
  Widget get pt2 => paddingOnly(top: 8);
  Widget get pt3 => paddingOnly(top: 12);
  Widget get pt4 => paddingOnly(top: 16);
  Widget get pt5 => paddingOnly(top: 20);
  Widget get pt6 => paddingOnly(top: 24);
  Widget get pt8 => paddingOnly(top: 32);

  Widget get pb1 => paddingOnly(bottom: 4);
  Widget get pb2 => paddingOnly(bottom: 8);
  Widget get pb3 => paddingOnly(bottom: 12);
  Widget get pb4 => paddingOnly(bottom: 16);
  Widget get pb5 => paddingOnly(bottom: 20);
  Widget get pb6 => paddingOnly(bottom: 24);
  Widget get pb8 => paddingOnly(bottom: 32);

  Widget get pl1 => paddingOnly(left: 4);
  Widget get pl2 => paddingOnly(left: 8);
  Widget get pl3 => paddingOnly(left: 12);
  Widget get pl4 => paddingOnly(left: 16);
  Widget get pl5 => paddingOnly(left: 20);
  Widget get pl6 => paddingOnly(left: 24);
  Widget get pl8 => paddingOnly(left: 32);

  Widget get pr1 => paddingOnly(right: 4);
  Widget get pr2 => paddingOnly(right: 8);
  Widget get pr3 => paddingOnly(right: 12);
  Widget get pr4 => paddingOnly(right: 16);
  Widget get pr5 => paddingOnly(right: 20);
  Widget get pr6 => paddingOnly(right: 24);
  Widget get pr8 => paddingOnly(right: 32);

  // Margin Extensions
  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value), child: this);

  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Container(
    margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );

  Widget get m0 => marginAll(0);
  Widget get m1 => marginAll(4);
  Widget get m2 => marginAll(8);
  Widget get m3 => marginAll(12);
  Widget get m4 => marginAll(16);
  Widget get m5 => marginAll(20);
  Widget get m6 => marginAll(24);
  Widget get m8 => marginAll(32);
  Widget get m10 => marginAll(40);
  Widget get m12 => marginAll(48);

  Widget get mx1 => marginSymmetric(horizontal: 4);
  Widget get mx2 => marginSymmetric(horizontal: 8);
  Widget get mx3 => marginSymmetric(horizontal: 12);
  Widget get mx4 => marginSymmetric(horizontal: 16);
  Widget get mx5 => marginSymmetric(horizontal: 20);
  Widget get mx6 => marginSymmetric(horizontal: 24);
  Widget get mx8 => marginSymmetric(horizontal: 32);
  Widget get mxAuto => Center(child: this);

  Widget get my1 => marginSymmetric(vertical: 4);
  Widget get my2 => marginSymmetric(vertical: 8);
  Widget get my3 => marginSymmetric(vertical: 12);
  Widget get my4 => marginSymmetric(vertical: 16);
  Widget get my5 => marginSymmetric(vertical: 20);
  Widget get my6 => marginSymmetric(vertical: 24);
  Widget get my8 => marginSymmetric(vertical: 32);

  Widget get mt1 => marginOnly(top: 4);
  Widget get mt2 => marginOnly(top: 8);
  Widget get mt3 => marginOnly(top: 12);
  Widget get mt4 => marginOnly(top: 16);
  Widget get mt5 => marginOnly(top: 20);
  Widget get mt6 => marginOnly(top: 24);
  Widget get mt8 => marginOnly(top: 32);
  Widget get mtAuto => Column(children: [const Spacer(), this]);

  Widget get mb1 => marginOnly(bottom: 4);
  Widget get mb2 => marginOnly(bottom: 8);
  Widget get mb3 => marginOnly(bottom: 12);
  Widget get mb4 => marginOnly(bottom: 16);
  Widget get mb5 => marginOnly(bottom: 20);
  Widget get mb6 => marginOnly(bottom: 24);
  Widget get mb8 => marginOnly(bottom: 32);
  Widget get mbAuto => Column(children: [this, const Spacer()]);

  Widget get ml1 => marginOnly(left: 4);
  Widget get ml2 => marginOnly(left: 8);
  Widget get ml3 => marginOnly(left: 12);
  Widget get ml4 => marginOnly(left: 16);
  Widget get ml5 => marginOnly(left: 20);
  Widget get ml6 => marginOnly(left: 24);
  Widget get ml8 => marginOnly(left: 32);
  Widget get mlAuto => Row(children: [const Spacer(), this]);

  Widget get mr1 => marginOnly(right: 4);
  Widget get mr2 => marginOnly(right: 8);
  Widget get mr3 => marginOnly(right: 12);
  Widget get mr4 => marginOnly(right: 16);
  Widget get mr5 => marginOnly(right: 20);
  Widget get mr6 => marginOnly(right: 24);
  Widget get mr8 => marginOnly(right: 32);
  Widget get mrAuto => Row(children: [this, const Spacer()]);

  // Padding Shortcuts
  EdgeInsets get padding0 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing0);
  EdgeInsets get padding1 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing1);
  EdgeInsets get padding2 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing2);
  EdgeInsets get padding3 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing3);
  EdgeInsets get padding4 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing4);
  EdgeInsets get padding5 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing5);
  EdgeInsets get padding6 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing6);
  EdgeInsets get padding8 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing8);
  EdgeInsets get padding10 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing10);
  EdgeInsets get padding12 =>
      EdgeInsets.all(navigatorKey.currentContext!.spacing12);

  // Legacy Padding
  EdgeInsets get paddingXS => EdgeInsets.all(navigatorKey.currentContext!.xs);
  EdgeInsets get paddingSM => EdgeInsets.all(navigatorKey.currentContext!.sm);
  EdgeInsets get paddingMD => EdgeInsets.all(navigatorKey.currentContext!.md);
  EdgeInsets get paddingLG => EdgeInsets.all(navigatorKey.currentContext!.lg);
  EdgeInsets get paddingXL => EdgeInsets.all(navigatorKey.currentContext!.xl);
  EdgeInsets get paddingXXL => EdgeInsets.all(navigatorKey.currentContext!.xxl);

  EdgeInsetsGeometry get paddingGeometry =>
      EdgeInsetsGeometry.all(navigatorKey.currentContext!.spacing0);

  // Horizontal Padding
  EdgeInsets get paddingHorizontal1 =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.spacing1);
  EdgeInsets get paddingHorizontal2 =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.spacing2);
  EdgeInsets get paddingHorizontal3 =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.spacing3);
  EdgeInsets get paddingHorizontal4 =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.spacing4);
  EdgeInsets get paddingHorizontal5 =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.spacing5);
  EdgeInsets get paddingHorizontal6 =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.spacing6);
  EdgeInsets get paddingHorizontal8 =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.spacing8);

  // Legacy Horizontal Padding
  EdgeInsets get paddingHorizontalXS =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.xs);
  EdgeInsets get paddingHorizontalSM =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.sm);
  EdgeInsets get paddingHorizontalMD =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.md);
  EdgeInsets get paddingHorizontalLG =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.lg);
  EdgeInsets get paddingHorizontalXL =>
      EdgeInsets.symmetric(horizontal: navigatorKey.currentContext!.xl);

  // Vertical Padding
  EdgeInsets get paddingVertical1 =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.spacing1);
  EdgeInsets get paddingVertical2 =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.spacing2);
  EdgeInsets get paddingVertical3 =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.spacing3);
  EdgeInsets get paddingVertical4 =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.spacing4);
  EdgeInsets get paddingVertical5 =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.spacing5);
  EdgeInsets get paddingVertical6 =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.spacing6);
  EdgeInsets get paddingVertical8 =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.spacing8);

  // Legacy Vertical Padding
  EdgeInsets get paddingVerticalXS =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.xs);
  EdgeInsets get paddingVerticalSM =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.sm);
  EdgeInsets get paddingVerticalMD =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.md);
  EdgeInsets get paddingVerticalLG =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.lg);
  EdgeInsets get paddingVerticalXL =>
      EdgeInsets.symmetric(vertical: navigatorKey.currentContext!.xl);

  // Context-aware padding
  Widget paddingContext(
    BuildContext context, {
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    EdgeInsets padding;

    if (all != null) {
      padding = EdgeInsets.all(all);
    } else if (horizontal != null || vertical != null) {
      padding = EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      );
    } else {
      padding = EdgeInsets.only(
        left: left ?? 0,
        top: top ?? 0,
        right: right ?? 0,
        bottom: bottom ?? 0,
      );
    }

    return Padding(padding: padding, child: this);
  }

  Widget cardWithPadding({
    EdgeInsets? padding,
    Color? color,
    double? elevation,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
  }) => Card(
    color: color,
    elevation: elevation ?? 2,
    margin: margin,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
    ),
    child: Padding(padding: padding ?? const EdgeInsets.all(16), child: this),
  );
  // // Padding Extensions
  // Widget paddingAll(double value) => Padding(padding: .all(value), child: this);

  // Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
  //     Padding(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: horizontal,
  //         vertical: vertical,
  //       ),
  //       child: this,
  //     );

  // Widget paddingOnly({
  //   double left = 0,
  //   double top = 0,
  //   double right = 0,
  //   double bottom = 0,
  // }) => Padding(
  //   padding: EdgeInsets.only(
  //     left: left,
  //     top: top,
  //     right: right,
  //     bottom: bottom,
  //   ),
  //   child: this,
  // );

  // Widget get p0 => paddingAll(0);
  // Widget get p1 => paddingAll(4);
  // Widget get p2 => paddingAll(8);
  // Widget get p3 => paddingAll(12);
  // Widget get p4 => paddingAll(16);
  // Widget get p5 => paddingAll(20);
  // Widget get p6 => paddingAll(24);
  // Widget get p8 => paddingAll(32);
  // Widget get p10 => paddingAll(40);
  // Widget get p12 => paddingAll(48);

  // Widget get px1 => paddingSymmetric(horizontal: 4);
  // Widget get px2 => paddingSymmetric(horizontal: 8);
  // Widget get px3 => paddingSymmetric(horizontal: 12);
  // Widget get px4 => paddingSymmetric(horizontal: 16);
  // Widget get px5 => paddingSymmetric(horizontal: 20);
  // Widget get px6 => paddingSymmetric(horizontal: 24);
  // Widget get px8 => paddingSymmetric(horizontal: 32);

  // Widget get py1 => paddingSymmetric(vertical: 4);
  // Widget get py2 => paddingSymmetric(vertical: 8);
  // Widget get py3 => paddingSymmetric(vertical: 12);
  // Widget get py4 => paddingSymmetric(vertical: 16);
  // Widget get py5 => paddingSymmetric(vertical: 20);
  // Widget get py6 => paddingSymmetric(vertical: 24);
  // Widget get py8 => paddingSymmetric(vertical: 32);

  // Widget get pt1 => paddingOnly(top: 4);
  // Widget get pt2 => paddingOnly(top: 8);
  // Widget get pt3 => paddingOnly(top: 12);
  // Widget get pt4 => paddingOnly(top: 16);
  // Widget get pt5 => paddingOnly(top: 20);
  // Widget get pt6 => paddingOnly(top: 24);
  // Widget get pt8 => paddingOnly(top: 32);

  // Widget get pb1 => paddingOnly(bottom: 4);
  // Widget get pb2 => paddingOnly(bottom: 8);
  // Widget get pb3 => paddingOnly(bottom: 12);
  // Widget get pb4 => paddingOnly(bottom: 16);
  // Widget get pb5 => paddingOnly(bottom: 20);
  // Widget get pb6 => paddingOnly(bottom: 24);
  // Widget get pb8 => paddingOnly(bottom: 32);

  // Widget get pl1 => paddingOnly(left: 4);
  // Widget get pl2 => paddingOnly(left: 8);
  // Widget get pl3 => paddingOnly(left: 12);
  // Widget get pl4 => paddingOnly(left: 16);
  // Widget get pl5 => paddingOnly(left: 20);
  // Widget get pl6 => paddingOnly(left: 24);
  // Widget get pl8 => paddingOnly(left: 32);

  // Widget get pr1 => paddingOnly(right: 4);
  // Widget get pr2 => paddingOnly(right: 8);
  // Widget get pr3 => paddingOnly(right: 12);
  // Widget get pr4 => paddingOnly(right: 16);
  // Widget get pr5 => paddingOnly(right: 20);
  // Widget get pr6 => paddingOnly(right: 24);
  // Widget get pr8 => paddingOnly(right: 32);

  // // Margin Extensions
  // Widget marginAll(double value) =>
  //     Container(margin: EdgeInsets.all(value), child: this);

  // Widget marginSymmetric({double horizontal = 0, double vertical = 0}) =>
  //     Container(
  //       margin: EdgeInsets.symmetric(
  //         horizontal: horizontal,
  //         vertical: vertical,
  //       ),
  //       child: this,
  //     );

  // Widget marginOnly({
  //   double left = 0,
  //   double top = 0,
  //   double right = 0,
  //   double bottom = 0,
  // }) => Container(
  //   margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
  //   child: this,
  // );

  // Widget get m0 => marginAll(0);
  // Widget get m1 => marginAll(4);
  // Widget get m2 => marginAll(8);
  // Widget get m3 => marginAll(12);
  // Widget get m4 => marginAll(16);
  // Widget get m5 => marginAll(20);
  // Widget get m6 => marginAll(24);
  // Widget get m8 => marginAll(32);
  // Widget get m10 => marginAll(40);
  // Widget get m12 => marginAll(48);

  // Widget get mx1 => marginSymmetric(horizontal: 4);
  // Widget get mx2 => marginSymmetric(horizontal: 8);
  // Widget get mx3 => marginSymmetric(horizontal: 12);
  // Widget get mx4 => marginSymmetric(horizontal: 16);
  // Widget get mx5 => marginSymmetric(horizontal: 20);
  // Widget get mx6 => marginSymmetric(horizontal: 24);
  // Widget get mx8 => marginSymmetric(horizontal: 32);
  // Widget get mxAuto => Center(child: this);

  // Widget get my1 => marginSymmetric(vertical: 4);
  // Widget get my2 => marginSymmetric(vertical: 8);
  // Widget get my3 => marginSymmetric(vertical: 12);
  // Widget get my4 => marginSymmetric(vertical: 16);
  // Widget get my5 => marginSymmetric(vertical: 20);
  // Widget get my6 => marginSymmetric(vertical: 24);
  // Widget get my8 => marginSymmetric(vertical: 32);

  // Widget get mt1 => marginOnly(top: 4);
  // Widget get mt2 => marginOnly(top: 8);
  // Widget get mt3 => marginOnly(top: 12);
  // Widget get mt4 => marginOnly(top: 16);
  // Widget get mt5 => marginOnly(top: 20);
  // Widget get mt6 => marginOnly(top: 24);
  // Widget get mt8 => marginOnly(top: 32);
  // Widget get mtAuto => Column(children: [const Spacer(), this]);

  // Widget get mb1 => marginOnly(bottom: 4);
  // Widget get mb2 => marginOnly(bottom: 8);
  // Widget get mb3 => marginOnly(bottom: 12);
  // Widget get mb4 => marginOnly(bottom: 16);
  // Widget get mb5 => marginOnly(bottom: 20);
  // Widget get mb6 => marginOnly(bottom: 24);
  // Widget get mb8 => marginOnly(bottom: 32);
  // Widget get mbAuto => Column(children: [this, const Spacer()]);

  // Widget get ml1 => marginOnly(left: 4);
  // Widget get ml2 => marginOnly(left: 8);
  // Widget get ml3 => marginOnly(left: 12);
  // Widget get ml4 => marginOnly(left: 16);
  // Widget get ml5 => marginOnly(left: 20);
  // Widget get ml6 => marginOnly(left: 24);
  // Widget get ml8 => marginOnly(left: 32);
  // Widget get mlAuto => Row(children: [const Spacer(), this]);

  // Widget get mr1 => marginOnly(right: 4);
  // Widget get mr2 => marginOnly(right: 8);
  // Widget get mr3 => marginOnly(right: 12);
  // Widget get mr4 => marginOnly(right: 16);
  // Widget get mr5 => marginOnly(right: 20);
  // Widget get mr6 => marginOnly(right: 24);
  // Widget get mr8 => marginOnly(right: 32);
  // Widget get mrAuto => Row(children: [this, const Spacer()]);
}

// Number Extensions
