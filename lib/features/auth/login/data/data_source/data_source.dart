import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../../../core/database/db_helper.dart';
import '../../../../../core/resources/helper_respons.dart';
import '../../../../../core/utils/enums.dart';
import '../model/model.dart';
import '../model/send_data.dart';

abstract class LoginDataSource {
  Future<HelperResponse> loginEasy(SendData loginModel);
}

class LoginDataSourceImpl implements LoginDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse> loginEasy(SendData loginModel) async {
    try {
      final adminMap = await _dbHelper
          .table('admins')
          .where('email', loginModel.email)
          .first();

      if (adminMap == null) {
        return HelperResponse.notFound(message: 'مافيش حساب بهذا الإيميل');
      }

      final admin = Admin.fromMap(adminMap);

      if (!admin.isActive) {
        return HelperResponse.authenticationError(message: 'الحساب محظور');
      }

      if (admin.passwordHash != _hashPassword(loginModel.password)) {
        return HelperResponse.authenticationError(message: 'كلمة السر غلط');
      }

      await _updateLastLogin(admin.id);

      return HelperResponse.success(
        data: admin,
        message: 'أهلاً وسهلاً ${admin.name}',
      );
    } catch (e) {
      return HelperResponse.error(
        message: 'حصل خطأ ما',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  Future<void> _updateLastLogin(int adminId) async {
    await _dbHelper.table('admins').where('id', adminId).update({
      'last_login_at': DateTime.now().toIso8601String(),
    });
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
