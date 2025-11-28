import 'package:gym_system/core/database/helper_respons.dart';
import 'package:gym_system/features/users/data/data_source/users_data_source.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';
import 'package:gym_system/features/users/domin/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final _usersDataSource = UsersDataSourceImpl();

  @override
  Future<HelperResponse> getUsers() {
    return _usersDataSource.getUsers();
  }

  @override
  Future<HelperResponse> addUser(UserModel user) {
    return _usersDataSource.addUser(user);
  }

  @override
  Future<HelperResponse> updateUser(UserModel user) {
    return _usersDataSource.updateUser(user);
  }

  @override
  Future<HelperResponse> deleteUser(int id) {
    return _usersDataSource.deleteUser(id);
  }
}
