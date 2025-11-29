import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';

abstract class UserListRepository {
  Future<HelperResponse<List<User>>> getUsers();
  Future<HelperResponse<void>> deleteUser(int id);
}
