import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gym_system/di/service_locator.dart';
import 'package:gym_system/features/auth/login/presentation/controller/state.dart';
import 'package:gym_system/gen/locale_keys.g.dart';

import '../../../../../commonWidget/app_field.dart';
import '../../../../../commonWidget/button_animation/LoadingButton.dart';
import '../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../../../gen/assets.gen.dart';
import '../controller/controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = sl<LoginController>();
    return Scaffold(
      body: Form(
        key: bloc.formKey,
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            MyAssets.icons.profilePicture1.image(width: 150.w).pb1,
            'Login View'.h4.center,
            AppCustomForm.email(
              hintText: tr(LocaleKeys.auth_email_placeholder),
              controller: TextEditingController(text: bloc.loginModel.email),
            ).pb3,
            AppCustomForm.password(
              hintText: tr(LocaleKeys.auth_password_placeholder),
              controller: TextEditingController(text: bloc.loginModel.password),
            ).pb3,
            BlocBuilder<LoginController, LoginState>(
              bloc: bloc,
              builder: (context, state) {
                return LoadingButton(
                  isAnimating: state.requestState.isLoading,
                  title: tr(LocaleKeys.auth_title),
                  onTap: () {
                    bloc.loginUser();
                  },
                );
              },
            ),
          ],
        ).center.pb8.px4,
      ),
    );
  }
}
