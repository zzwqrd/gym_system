import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/di/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../commonWidget/toast_helper.dart';
import '../../../../../core/database/db_helper.dart';
import '../../../../../core/database/helper_respons.dart';
import '../../../../../core/utils/enums.dart';
import 'model.dart';
import 'send_data.dart';
import 'state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController() : super(LoginState());
  final formKey = GlobalKey<FormState>();
  final DBHelper _dbHelper = DBHelper();
  final pref = sl<SharedPreferences>();
  SendData loginModel = SendData(
    email: "admin@admin.com".trim(),
    password: "1234567".trim(),
  );

  Future<HelperResponse<Admin>> loginEasy() async {
    if (!formKey.currentState!.validate()) {
      return HelperResponse.validationError(message: 'البيانات غير صحيحة');
    }
    formKey.currentState?.save();

    try {
      final adminMap = await _dbHelper
          .table('admins')
          .where('email', loginModel.email)
          .first();

      if (adminMap == null) {
        return HelperResponse.notFound(message: 'مافيش حساب بهذا الإيميل');
      }

      final admin = Admin.fromMap(adminMap);

      // إذا الحساب محظور
      if (!admin.isActive) {
        return HelperResponse.authenticationError(message: 'الحساب محظور');
      }

      // إذا الباسوورد غلط
      if (admin.passwordHash != _hashPassword(loginModel.password)) {
        return HelperResponse.authenticationError(message: 'كلمة السر غلط');
      }

      // كل شيء تمام - نحدث وقت الدخول
      await _updateLastLogin(admin.id);

      // نرجع النجاح
      return HelperResponse.success(
        data: admin,
        message: 'أهلاً وسهلاً ${admin.name}',
      );
    } catch (e) {
      // إذا حصل خطأ غير متوقع
      return HelperResponse.error(
        message: 'حصل خطأ ما',
        errorType: ErrorRequestType.notFound,
      );
    }
  }

  // 2. دالة تحديث وقت الدخول - سهلة
  Future<void> _updateLastLogin(int adminId) async {
    await _dbHelper.table('admins').where('id', adminId).update({
      'last_login_at': DateTime.now().toIso8601String(),
    });
  }

  // 3. دالة الهاش - سهلة
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> loginUser() async {
    emit(state.copyWith(requestState: RequestState.loading));

    final response = await loginEasy();

    response.when(
      success: (admin) {
        // نحفظ التوكن
        pref.setString("admin_token", admin.token);

        // نظهر رسالة نجاح
        FlashHelper.showToast(response.message, type: MessageTypeTost.success);

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
    emit(state.copyWith(requestState: RequestState.loading));

    final response = await loginEasy();
    final result = response.toEither();

    result.fold(
      // إذا كان فيه خطأ
      (errorMessage) {
        FlashHelper.showToast(errorMessage, type: MessageTypeTost.fail);
        emit(state.copyWith(requestState: RequestState.error));
      },
      // إذا نجح
      (admin) {
        pref.setString("admin_token", admin.token);
        FlashHelper.showToast(
          'أهلاً بك ${admin.name}',
          type: MessageTypeTost.success,
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
