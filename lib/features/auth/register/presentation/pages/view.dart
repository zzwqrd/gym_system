import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gym_system/di/service_locator.dart';
import 'package:gym_system/features/auth/register/presentation/controller/state.dart';
import 'package:gym_system/gen/locale_keys.g.dart';

import '../../../../../commonWidget/app_field.dart';
import '../../../../../commonWidget/button_animation/LoadingButton.dart';
import '../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../../../gen/assets.gen.dart';
import '../../data/model/send_data.dart';
import '../controller/controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = sl<RegisterController>();
    return Scaffold(
      body: Form(
        key: bloc.formKey,
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            MyAssets.icons.profilePicture1.image(width: 150.w).pb1,
            'Register View'.h4.center,
            AppCustomForm.text(
              hintText:
                  'Name', // يمكن استبدالها بـ tr(LocaleKeys.auth_name_placeholder) إذا وجد
              controller: TextEditingController(text: bloc.registerModel.name),
              onChanged: (v) => bloc.registerModel = RegisterSendData(
                name: v,
                email: bloc.registerModel.email,
                password: bloc.registerModel.password,
              ),
            ).pb3,
            AppCustomForm.email(
              hintText: tr(LocaleKeys.auth_email_placeholder),
              controller: TextEditingController(text: bloc.registerModel.email),
              onChanged: (v) => bloc.registerModel = RegisterSendData(
                name: bloc.registerModel.name,
                email: v,
                password: bloc.registerModel.password,
              ),
            ).pb3,
            AppCustomForm.password(
              hintText: tr(LocaleKeys.auth_password_placeholder),
              controller: TextEditingController(
                text: bloc.registerModel.password,
              ),
              onChanged: (v) => bloc.registerModel = RegisterSendData(
                name: bloc.registerModel.name,
                email: bloc.registerModel.email,
                password: v,
              ),
            ).pb3,
            BlocBuilder<RegisterController, RegisterState>(
              bloc: bloc,
              builder: (context, state) {
                return LoadingButton(
                  isAnimating: state.requestState.isLoading,
                  title:
                      'Register', // يمكن استبدالها بـ tr(LocaleKeys.auth_register_title)
                  onTap: () {
                    bloc.registerAdmin();
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
