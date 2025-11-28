import 'package:gym_system/core/database/helper_respons.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';
import 'package:gym_system/features/users/data/repository_impl/users_repository_impl.dart';

abstract class UsersUseCase {
  Future<HelperResponse> getUsers();
  Future<HelperResponse> addUser(UserModel user);
  Future<HelperResponse> updateUser(UserModel user);
  Future<HelperResponse> deleteUser(int id);
}

class UsersUseCaseImpl implements UsersUseCase {
  final _usersRepository = UsersRepositoryImpl();

  @override
  Future<HelperResponse> getUsers() {
    return _usersRepository.getUsers();
  }

  @override
  Future<HelperResponse> addUser(UserModel user) {
    return _usersRepository.addUser(user);
  }

  @override
  Future<HelperResponse> updateUser(UserModel user) {
    return _usersRepository.updateUser(user);
  }

  @override
  Future<HelperResponse> deleteUser(int id) {
    return _usersRepository.deleteUser(id);
  }
}
