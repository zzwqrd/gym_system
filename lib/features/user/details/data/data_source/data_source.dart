import '../../../../../../core/database/db_helper.dart';
import '../../../../../../core/resources/helper_respons.dart';
import '../../../../../../core/utils/enums.dart';
import '../model/model.dart';

abstract class UserDetailsDataSource {
  Future<HelperResponse<User>> getUserById(int id);
}

class UserDetailsDataSourceImpl implements UserDetailsDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse<User>> getUserById(int id) async {
    try {
      final result = await _dbHelper.table('users').where('id', id).first();
      if (result != null) {
        return HelperResponse.success(data: User.fromMap(result));
      } else {
        return HelperResponse.error(
          message: 'المشترك غير موجود',
          errorType: ErrorRequestType.notFound,
        );
      }
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء جلب البيانات',
        errorType: ErrorRequestType.unknown,
      );
    }
  }
}
