import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/di/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../commonWidget/toast_helper.dart';
import '../../../../../core/database/db_helper.dart';
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

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState?.save();

    emit(state.copyWith(requestState: RequestState.loading));

    // السؤال المنطقي: "هل يمكن تسجيل الدخول؟"
    final canLogin = await _dbHelper
        .table('admins')
        .where('email', loginModel.email)
        .where('password_hash', _hashPassword(loginModel.password))
        .where('is_active', 1)
        .exists();

    if (!canLogin) {
      FlashHelper.showToast(
        'بيانات الدخول غير صحيحة',
        type: MessageTypeTost.fail,
      );
      emit(state.copyWith(requestState: RequestState.error));
      return;
    } else {
      // التنفيذ المنطقي
      final admin = await _dbHelper
          .table('admins')
          .where('email', loginModel.email)
          .first()
          .then((map) => Admin.fromMap(map!));
      await pref.setString("admin_token", admin.token);
      await _updateLastLogin(admin.id);
      FlashHelper.showToast(
        'مرحباً بك ${admin.name}',
        type: MessageTypeTost.success,
      );
      emit(state.copyWith(requestState: RequestState.done));
    }
  }

  // دالة التشفير (نفس المستخدمة في الميجرايشن)
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // تحديث وقت آخر تسجيل دخول
  Future<void> _updateLastLogin(int adminId) async {
    try {
      await _dbHelper.table('admins').where('id', adminId).update({
        'last_login_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Failed to update last login: $e');
      }
    }
  }
}
