import 'package:gym_system/core/database/helper_respons.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';

abstract class UsersRepository {
  Future<HelperResponse> getUsers();
  Future<HelperResponse> addUser(UserModel user);
  Future<HelperResponse> updateUser(UserModel user);
  Future<HelperResponse> deleteUser(int id);
}
