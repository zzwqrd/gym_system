import '../../../../../../core/database/db_helper.dart';
import '../../../../../../core/resources/helper_respons.dart';
import '../../../../../../core/utils/enums.dart';
import '../model/model.dart';

abstract class AdminDetailsDataSource {
  Future<HelperResponse<Admin>> getAdminById(int id);
}

class AdminDetailsDataSourceImpl implements AdminDetailsDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse<Admin>> getAdminById(int id) async {
    try {
      final result = await _dbHelper.table('admins').where('id', id).first();
      if (result != null) {
        return HelperResponse.success(data: Admin.fromMap(result));
      } else {
        return HelperResponse.error(
          message: 'المسؤول غير موجود',
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
