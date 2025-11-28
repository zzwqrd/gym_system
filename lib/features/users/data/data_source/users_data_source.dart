import 'package:gym_system/core/database/db_helper.dart';
import 'package:gym_system/core/database/helper_respons.dart';
import 'package:gym_system/core/utils/enums.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';

abstract class UsersDataSource {
  Future<HelperResponse> getUsers();
  Future<HelperResponse> addUser(UserModel user);
  Future<HelperResponse> updateUser(UserModel user);
  Future<HelperResponse> deleteUser(int id);
}

class UsersDataSourceImpl implements UsersDataSource {
  final _dbHelper = DBHelper();

  @override
  Future<HelperResponse> getUsers() async {
    try {
      final result = await _dbHelper.rawQuery(
        'SELECT * FROM users ORDER BY created_at DESC',
      );
      final users = result.map((json) => UserModel.fromJson(json)).toList();
      return HelperResponse.success(data: users);
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to fetch users: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse> addUser(UserModel user) async {
    try {
      await _dbHelper.table('users').insert(user.toJson());
      return HelperResponse.success(message: 'User added successfully');
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to add user: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse> updateUser(UserModel user) async {
    try {
      if (user.id == null) {
        return HelperResponse.error(message: 'User ID is required for update');
      }
      await _dbHelper.table('users').where('id', user.id).update(user.toJson());
      return HelperResponse.success(message: 'User updated successfully');
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to update user: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }

  @override
  Future<HelperResponse> deleteUser(int id) async {
    try {
      await _dbHelper.table('users').where('id', id).delete();
      return HelperResponse.success(message: 'User deleted successfully');
    } catch (e) {
      return HelperResponse.error(
        message: 'Failed to delete user: $e',
        errorType: ErrorRequestType.unknown,
      );
    }
  }
}
