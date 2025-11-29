import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/repository_impl/repository_impl.dart';
import '../repositories/repository.dart';

abstract class UserListUseCase {
  Future<HelperResponse<List<User>>> getUsers();
  Future<HelperResponse<void>> deleteUser(int id);
}

class UserListUseCaseImpl implements UserListUseCase {
  final UserListRepository _repository = UserListRepositoryImpl();

  @override
  Future<HelperResponse<List<User>>> getUsers() {
    return _repository.getUsers();
  }

  @override
  Future<HelperResponse<void>> deleteUser(int id) {
    return _repository.deleteUser(id);
  }
}
