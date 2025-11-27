import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../../../core/database/db_helper.dart';
import '../../../../../core/database/helper_respons.dart';
import '../../../../../core/utils/enums.dart';
import '../model/model.dart';
import '../model/send_data.dart';

abstract class RegisterDataSource {
  Future<HelperResponse> registerAdmin(RegisterSendData registerModel);
}

class RegisterDataSourceImpl implements RegisterDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse> registerAdmin(RegisterSendData registerModel) async {
    try {
      // التحقق من وجود البريد الإلكتروني
      final existingAdmin = await _dbHelper
          .table('admins')
          .where('email', registerModel.email)
          .first();

      if (existingAdmin != null) {
        return HelperResponse.error(
          message: 'البريد الإلكتروني موجود بالفعل',
          errorType: ErrorRequestType.validationError,
        );
      }

      // الحصول على role_id (افتراضياً super_admin)
      final superAdminRole = await _dbHelper
          .table('roles')
          .where('name', 'super_admin')
          .first();

      if (superAdminRole == null) {
        return HelperResponse.error(
          message: 'خطأ في إعدادات النظام',
          errorType: ErrorRequestType.unknown,
        );
      }

      final roleId = superAdminRole['id'] as int;
      final now = DateTime.now().toIso8601String();
      final passwordHash = _hashPassword(registerModel.password);
      final token = _generateToken(registerModel.email);

      // إدراج admin جديد
      final adminData = {
        'name': registerModel.name,
        'email': registerModel.email,
        'password_hash': passwordHash,
        'token': token,
        'role_id': roleId,
        'is_active': 1,
        'created_at': now,
        'updated_at': now,
      };

      final adminId = await _dbHelper.table('admins').insert(adminData);

      // جلب البيانات المدرجة
      final insertedAdminMap = await _dbHelper
          .table('admins')
          .where('id', adminId)
          .first();

      if (insertedAdminMap == null) {
        return HelperResponse.error(
          message: 'فشل في إنشاء الحساب',
          errorType: ErrorRequestType.unknown,
        );
      }

      final admin = Admin.fromMap(insertedAdminMap);

      return HelperResponse.success(
        data: admin,
        message: 'تم إنشاء الحساب بنجاح',
      );
    } catch (e) {
      return HelperResponse.error(
        message: 'حصل خطأ ما: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String _generateToken(String email) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final raw = '$email-$timestamp';
    final bytes = utf8.encode(raw);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
