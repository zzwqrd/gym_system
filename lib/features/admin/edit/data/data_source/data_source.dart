import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../../../../../../core/database/db_helper.dart';
import '../../../../../../core/resources/helper_respons.dart';
import '../../../../../../core/utils/enums.dart';
import '../model/model.dart';
import '../model/send_data.dart';

abstract class EditAdminDataSource {
  Future<HelperResponse<Admin>> updateAdmin(int id, SendData sendData);
}

class EditAdminDataSourceImpl implements EditAdminDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse<Admin>> updateAdmin(int id, SendData sendData) async {
    try {
      final dataToUpdate = sendData.toMap();

      if (sendData.password != null && sendData.password!.isNotEmpty) {
        dataToUpdate['password_hash'] = _hashPassword(sendData.password!);
        dataToUpdate.remove('password');
      }

      dataToUpdate['updated_at'] = DateTime.now().toIso8601String();

      await _dbHelper.table('admins').where('id', id).update(dataToUpdate);

      final updatedAdminMap = await _dbHelper
          .table('admins')
          .where('id', id)
          .first();
      return HelperResponse.success(data: Admin.fromMap(updatedAdminMap!));
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء التعديل',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
