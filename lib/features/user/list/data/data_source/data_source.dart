import '../../../../../../core/database/db_helper.dart';
import '../../../../../../core/resources/helper_respons.dart';
import '../../../../../../core/utils/enums.dart';
import '../model/model.dart';

abstract class UserListDataSource {
  Future<HelperResponse<List<User>>> getUsers();
  Future<HelperResponse<void>> deleteUser(int id);
}

class UserListDataSourceImpl implements UserListDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse<List<User>>> getUsers() async {
    try {
      final result = await _dbHelper.table('users').get();
      final users = result.map((e) => User.fromMap(e)).toList();
      return HelperResponse.success(data: users);
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء جلب البيانات',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse<void>> deleteUser(int id) async {
    try {
      await _dbHelper.table('users').where('id', id).delete();
      return HelperResponse.success(data: null);
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء الحذف',
        errorType: ErrorRequestType.unknown,
      );
    }
  }
}
