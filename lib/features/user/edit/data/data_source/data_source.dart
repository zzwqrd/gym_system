import '../../../../../../core/database/db_helper.dart';
import '../../../../../../core/resources/helper_respons.dart';
import '../../../../../../core/utils/enums.dart';
import '../model/model.dart';
import '../model/send_data.dart';

abstract class EditUserDataSource {
  Future<HelperResponse<User>> updateUser(int id, SendData sendData);
}

class EditUserDataSourceImpl implements EditUserDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse<User>> updateUser(int id, SendData sendData) async {
    try {
      final dataToUpdate = sendData.toMap();
      dataToUpdate['updated_at'] = DateTime.now().toIso8601String();

      await _dbHelper.table('users').where('id', id).update(dataToUpdate);

      final updatedUserMap = await _dbHelper
          .table('users')
          .where('id', id)
          .first();
      return HelperResponse.success(data: User.fromMap(updatedUserMap!));
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء التعديل',
        errorType: ErrorRequestType.unknown,
      );
    }
  }
}
