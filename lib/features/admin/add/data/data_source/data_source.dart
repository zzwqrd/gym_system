import '../../../../../core/database/db_helper.dart';
import '../../../../../core/resources/helper_respons.dart';
import '../../../../../core/utils/enums.dart';
import '../models/add_admin_send_data.dart';

abstract class AddAdminDataSource {
  Future<HelperResponse> addAdmin(AddAdminSendData admin);
  Future<HelperResponse<bool>> checkEmail(String email);
}

class AddAdminDataSourceImpl implements AddAdminDataSource {
  final _dbHelper = DBHelper();
  @override
  Future<HelperResponse> addAdmin(AddAdminSendData admin) async {
    try {
      final adminMap = await _dbHelper.table('admins').insert(admin.toJson());
      final checkEmailResponse = await checkEmail(admin.email);
      if (checkEmailResponse.data == true) {
        return HelperResponse.error(
          message: 'البريد الالكتروني موجود بالفعل',
          errorType: ErrorRequestType.unknown,
        );
      }

      return HelperResponse.success(
        message: 'تم إضافة المسؤول بنجاح',
        data: adminMap,
      );
    } catch (e) {
      return HelperResponse.error(
        message: 'حصل خطأ ما',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse<bool>> checkEmail(String email) async {
    try {
      final adminMap = await _dbHelper
          .table('admins')
          .where('email', email)
          .first();
      if (adminMap == null) {
        return HelperResponse.success(
          data: true,
          message: 'تم إضافة المسؤول بنجاح',
        );
      } else {
        return HelperResponse.error(
          message: 'البريد الالكتروني موجود بالفعل',
          errorType: ErrorRequestType.unknown,
        );
      }
    } catch (e) {
      return HelperResponse.error(
        message: 'حصل خطأ ما',
        errorType: ErrorRequestType.unknown,
      );
    }
  }
}
