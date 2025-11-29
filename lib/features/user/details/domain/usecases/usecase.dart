import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/repository_impl/repository_impl.dart';
import '../repositories/repository.dart';

abstract class UserDetailsUseCase {
  Future<HelperResponse<User>> getUserById(int id);
}

class UserDetailsUseCaseImpl implements UserDetailsUseCase {
  final UserDetailsRepository _repository = UserDetailsRepositoryImpl();

  @override
  Future<HelperResponse<User>> getUserById(int id) {
    return _repository.getUserById(id);
  }
}
