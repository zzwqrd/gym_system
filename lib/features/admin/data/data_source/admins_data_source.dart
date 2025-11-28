import 'package:gym_system/core/database/db_helper.dart';
import 'package:gym_system/core/database/helper_respons.dart';
import 'package:gym_system/core/utils/enums.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';

abstract class AdminsDataSource {
  Future<HelperResponse> getAdmins();
  Future<HelperResponse> addAdmin(AdminModel admin);
  Future<HelperResponse> updateAdmin(AdminModel admin);
  Future<HelperResponse> deleteAdmin(int id);
  Future<HelperResponse> getRoles();
}

class AdminsDataSourceImpl implements AdminsDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse> getRoles() async {
    try {
      final result = await _dbHelper.rawQuery('SELECT * FROM roles');
      return HelperResponse.success(data: result);
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to fetch roles: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse> getAdmins() async {
    try {
      final result = await _dbHelper.rawQuery(
        'SELECT * FROM admins ORDER BY created_at DESC',
      );
      final admins = result.map((json) => AdminModel.fromJson(json)).toList();
      return HelperResponse.success(data: admins);
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to fetch admins: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse> addAdmin(AdminModel admin) async {
    try {
      await _dbHelper.table('admins').insert(admin.toJson());
      return HelperResponse.success(message: 'Admin added successfully');
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to add admin: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse> updateAdmin(AdminModel admin) async {
    try {
      if (admin.id == null) {
        return HelperResponse.error(message: 'Admin ID is required for update');
      }
      await _dbHelper
          .table('admins')
          .where('id', admin.id)
          .update(admin.toJson());
      return HelperResponse.success(message: 'Admin updated successfully');
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to update admin: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse> deleteAdmin(int id) async {
    try {
      await _dbHelper.table('admins').where('id', id).delete();
      return HelperResponse.success(message: 'Admin deleted successfully');
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to delete admin: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }
}
