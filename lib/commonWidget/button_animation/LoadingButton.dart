import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commonWidget/button_animation/loading_app.dart';
import '../../core/utils/ui_extensions/complete_flutter_extensions.dart'
    show AppColors;
import '../../core/utils/ui_extensions/style_extensions_mor.dart'
    show AppTextStyles;
import '../app_text.dart';
import 'button_animation.dart';

class LoadingButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final bool isAnimating; // إضافة الخاصية isAnimating

  const LoadingButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderColor,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    required this.isAnimating, // إضافة الخاصية هنا
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonAnimation(
      isAnimating: isAnimating, // تمرير isAnimating
      onTap: () {
        if (isAnimating != true) {
          onTap.call();
        }
      },
      width: width ?? MediaQuery.of(context).size.width,
      minWidth: 55.w,
      height: height ?? 53.h,
      color: color ?? context.primaryColor,
      borderRadius: borderRadius ?? 10,
      // borderSide: BorderSide(
      //   color:
      //       borderColor ??
      //       const Color.fromARGB(0, 255, 255, 255).withOpacity(0.0),
      //   width: 1.w,
      // ),
      loader: const LoadingBtn(),
      child: MyTextApp(
        title: title,
        style: context.bodyMedium.copyWith(
          color: textColor ?? Colors.white,
          fontSize: fontSize ?? 16.sp,
          fontFamily: fontFamily ?? 'Cairo',
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}
