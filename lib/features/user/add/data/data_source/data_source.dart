import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../../../../../../core/database/db_helper.dart';
import '../../../../../../core/resources/helper_respons.dart';
import '../../../../../../core/utils/enums.dart';
import '../model/model.dart';
import '../model/send_data.dart';

abstract class AddUserDataSource {
  Future<HelperResponse<User>> addUser(SendData sendData);
}

class AddUserDataSourceImpl implements AddUserDataSource {
  final _dbHelper = DBHelper();

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<HelperResponse<User>> addUser(SendData sendData) async {
    try {
      // Check if email exists
      final exists = await _dbHelper
          .table('users')
          .where('email', sendData.email)
          .exists();

      if (exists) {
        return HelperResponse.error(
          message: 'البريد الإلكتروني مستخدم بالفعل',
          errorType: ErrorRequestType.validationError,
        );
      }

      final now = DateTime.now().toIso8601String();
      final passwordHash = _hashPassword(sendData.password ?? '123456');

      final id = await _dbHelper.table('users').insert({
        'name': sendData.name,
        'email': sendData.email,
        'phone': sendData.phone,
        'national_id': sendData.nationalId,
        'password_hash': passwordHash,
        'is_active': sendData.isActive! ? 1 : 0,
        'created_at': now,
        'updated_at': now,
      });

      final newUserMap = await _dbHelper.table('users').where('id', id).first();
      return HelperResponse.success(data: User.fromMap(newUserMap!));
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء الإضافة',
        errorType: ErrorRequestType.unknown,
      );
    }
  }
}
