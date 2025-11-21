import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/database/db_helper.dart';
import '../../../../../core/utils/enums.dart';
import 'model.dart';
import 'send_data.dart';
import 'state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController() : super(LoginState());
  final formKey = GlobalKey<FormState>();
  final DBHelper _dbHelper = DBHelper();
  SendData loginModel = SendData(
    email: "admin@admin.com".trim(),
    password: "1234567".trim(),
  );

  Future<void> login() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      formKey.currentState?.save();
      emit(state.copyWith(requestState: RequestState.loading));
      // 1. تشفير الباسورد المدخل
      final hashedPassword = _hashPassword(loginModel.password);

      // 2. البحث عن الأدمن في قاعدة البيانات
      final adminMap = await _dbHelper
          .table('admins')
          .where('email', loginModel.email)
          .where('password_hash', hashedPassword)
          .where('is_active', 1)
          .first();

      if (adminMap != null) {
        // 3. تحويل البيانات إلى مودل
        final admin = Admin.fromMap(adminMap);

        // 4. تحديث وقت آخر تسجيل دخول (اختياري)
        await _updateLastLogin(admin.id);
        log("🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵🪵 $admin");
        emit(state.copyWith(requestState: RequestState.done));
      } else {
        emit(state.copyWith(requestState: RequestState.error));
      }
    } catch (e) {
      emit(state.copyWith(requestState: RequestState.error));
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
