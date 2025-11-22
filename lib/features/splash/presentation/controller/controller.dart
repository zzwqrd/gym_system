import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../commonWidget/toast_helper.dart';
import '../../../../core/routes/app_routes_fun.dart';
import '../../../../core/routes/navigation.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/enums.dart';
import '../../../../di/service_locator.dart';
import 'state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashState());
  final pref = sl<SharedPreferences>();

  Future<void> init() async {
    Future.delayed(Duration(seconds: 2), () async {
      if (pref.getString("admin_token") != null ||
          pref.getString("admin_token")!.trim().isNotEmpty) {
        FlashHelper.showToast('مرحباً بك ', type: MessageTypeTost.success);

        await navigatorKey.currentContext!.pushNamedAndRemoveUntil(
          RouteNames.mainLayout,
          predicate: (Route<dynamic> route) => false,
        );
      } else {
        await navigatorKey.currentContext!.pushNamedAndRemoveUntil(
          RouteNames.login,
          predicate: (Route<dynamic> route) => false,
        );
      }
      emit(state.copyWith(requestState: RequestState.done));
    });
  }
}
