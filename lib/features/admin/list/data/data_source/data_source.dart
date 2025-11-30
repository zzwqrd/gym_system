import '../../../../../../core/database/db_helper.dart';
import '../../../../../../core/resources/helper_respons.dart';
import '../../../../../../core/utils/enums.dart';
import '../model/model.dart';

abstract class AdminListDataSource {
  Future<HelperResponse<List<Admin>>> getAdmins();
  Future<HelperResponse<void>> deleteAdmin(int id);
}

class AdminListDataSourceImpl implements AdminListDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse<List<Admin>>> getAdmins() async {
    try {
      final result = await _dbHelper
          .table('admins')
          .orderBy('id', direction: "desc")
          .get();
      final admins = result.map((e) => Admin.fromMap(e)).toList();
      return HelperResponse.success(data: admins);
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء جلب البيانات',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse<void>> deleteAdmin(int id) async {
    try {
      await _dbHelper.table('admins').where('id', id).delete();
      return HelperResponse.success(data: null);
    } catch (e) {
      return HelperResponse.error(
        message: 'حدث خطأ أثناء الحذف',
        errorType: ErrorRequestType.unknown,
      );
    }
  }
}
