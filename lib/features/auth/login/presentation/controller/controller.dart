import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/di/service_locator.dart';
import 'package:gym_system/features/auth/login/domin/usecases/usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../commonWidget/toast_helper.dart';
import '../../../../../core/routes/app_routes_fun.dart';
import '../../../../../core/routes/navigation.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/enums.dart';
import '../../data/model/send_data.dart';
import 'state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController() : super(LoginState());
  final formKey = GlobalKey<FormState>();
  final pref = sl<SharedPreferences>();
  final LoginUsecase _loginUseCase = LoginUsecaseImpl();
  SendData loginModel = SendData(
    email: "admin@admin.com".trim(),
    password: "1234567".trim(),
  );

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState?.save();
    emit(state.copyWith(requestState: RequestState.loading));

    final response = await _loginUseCase.loginEasy(loginModel);

    response.when(
      success: (admin) async {
        // نحفظ التوكن
        pref.setString("admin_token", admin.token);

        // نظهر رسالة نجاح
        FlashHelper.showToast(response.message, type: MessageTypeTost.success);
        await navigatorKey.currentContext!.pushNamedAndRemoveUntil(
          RouteNames.mainLayout,
          predicate: (Route<dynamic> route) => false,
        );

        // نغير الحالة لنجاح
        emit(state.copyWith(requestState: RequestState.done));
      },
      error: (message, errorType) {
        // نظهر رسالة خطأ
        FlashHelper.showToast(message, type: MessageTypeTost.fail);

        // نغير الحالة لخطأ
        emit(state.copyWith(requestState: RequestState.error));
      },
    );
  }

  // 5. أو باستخدام Either إذا كنت تفضله
  Future<void> loginUserWithEither() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState?.save();
    emit(state.copyWith(requestState: RequestState.loading));

    final response = await _loginUseCase.loginEasy(loginModel);
    final result = response.toEither();

    result.fold(
      // إذا كان فيه خطأ
      (errorMessage) {
        FlashHelper.showToast(errorMessage, type: MessageTypeTost.fail);
        emit(state.copyWith(requestState: RequestState.error));
      },
      // إذا نجح
      (admin) async {
        pref.setString("admin_token", admin.token);
        FlashHelper.showToast(
          'أهلاً بك ${admin.name}',
          type: MessageTypeTost.success,
        );
        await navigatorKey.currentContext!.pushNamedAndRemoveUntil(
          RouteNames.mainLayout,
          predicate: (Route<dynamic> route) => false,
        );
        emit(state.copyWith(requestState: RequestState.done));
      },
    );
  }
  // تسجيل بلطريقه القديمه
  // Future<void> login() async {
  //   if (!formKey.currentState!.validate()) return;
  //   formKey.currentState?.save();

  //   emit(state.copyWith(requestState: RequestState.loading));

  //   // السؤال المنطقي: "هل يمكن تسجيل الدخول؟"
  //   final canLogin = await _dbHelper
  //       .table('admins')
  //       .where('email', loginModel.email)
  //       .where('password_hash', _hashPassword(loginModel.password))
  //       .where('is_active', 1)
  //       .exists();

  //   if (!canLogin) {
  //     FlashHelper.showToast(
  //       'بيانات الدخول غير صحيحة',
  //       type: MessageTypeTost.fail,
  //     );
  //     emit(state.copyWith(requestState: RequestState.error));
  //     return;
  //   } else {
  //     // التنفيذ المنطقي
  //     final admin = await _dbHelper
  //         .table('admins')
  //         .where('email', loginModel.email)
  //         .first()
  //         .then((map) => Admin.fromMap(map!));
  //     await pref.setString("admin_token", admin.token);
  //     await _updateLastLogin(admin.id);
  //     FlashHelper.showToast(
  //       'مرحباً بك ${admin.name}',
  //       type: MessageTypeTost.success,
  //     );
  //     emit(state.copyWith(requestState: RequestState.done));
  //   }
  // }

  // // دالة التشفير (نفس المستخدمة في الميجرايشن)
  // String _hashPassword(String password) {
  //   final bytes = utf8.encode(password);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }

  // // تحديث وقت آخر تسجيل دخول
  // Future<void> _updateLastLogin(int adminId) async {
  //   try {
  //     await _dbHelper.table('admins').where('id', adminId).update({
  //       'last_login_at': DateTime.now().toIso8601String(),
  //       'updated_at': DateTime.now().toIso8601String(),
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('⚠️ Failed to update last login: $e');
  //     }
  //   }
  // }
}
