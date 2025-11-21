import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_system/core/utils/ui_extensions/box_extensions.dart'
    show BoxExtensions;
import 'package:gym_system/core/utils/ui_extensions/text_style_extensions.dart';
import 'package:gym_system/gen/locale_keys.g.dart';

import '../../../../../commonWidget/app_field.dart';
import '../../../../../commonWidget/button_animation/LoadingButton.dart';
import '../../../../../gen/assets.gen.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          MyAssets.icons.profilePicture1.image(width: 150.w).pb1,
          'Login View'.h4.center,
          AppCustomForm.email(
            hintText: tr(LocaleKeys.auth_email_placeholder),
            controller: TextEditingController(text: ""),
          ).pb3,
          AppCustomForm.password(
            hintText: tr(LocaleKeys.auth_password_placeholder),
            controller: TextEditingController(text: ""),
          ).pb3,
          LoadingButton(
            isAnimating: false,
            title: tr(LocaleKeys.auth_title),
            onTap: () {},
          ),
        ],
      ).center.pb8.px4,
    );
  }
}
