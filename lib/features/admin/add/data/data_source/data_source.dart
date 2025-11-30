import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../../../../../../core/database/db_helper.dart';
import '../../../../../../core/resources/helper_respons.dart';
import '../../../../../../core/utils/enums.dart';
import '../model/model.dart';
import '../model/send_data.dart';

abstract class AddAdminDataSource {
  Future<HelperResponse<Admin>> addAdmin(SendData sendData);
}

class AddAdminDataSourceImpl implements AddAdminDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse<Admin>> addAdmin(SendData sendData) async {
    try {
      final exists = await _dbHelper
          .table('admins')
          .where('email', sendData.email)
          .exists();

      if (exists) {
        return HelperResponse.error(
          message: 'البريد الإلكتروني مستخدم بالفعل',
          errorType: ErrorRequestType.validationError,
        );
      }

      final now = DateTime.now().toIso8601String();
      final passwordHash = _hashPassword(sendData.password!);
      final token = _generateToken(sendData.email!);

      final id = await _dbHelper.table('admins').insert({
        'name': sendData.name,
        'email': sendData.email,
        'password_hash': passwordHash,
        'token': token,
        'role_id': sendData.roleId,
        'is_active': sendData.isActive! ? 1 : 0,
        'created_at': now,
        'updated_at': now,
      });

      final newAdminMap = await _dbHelper
          .table('admins')
          .where('id', id)
          .first();
      return HelperResponse.success(data: Admin.fromMap(newAdminMap!));
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء الإضافة',
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
    final bytes = utf8.encode('$email${DateTime.now().millisecondsSinceEpoch}');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
