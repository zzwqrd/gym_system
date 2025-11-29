import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../../data/repository_impl/repository_impl.dart';
import '../repositories/repository.dart';

abstract class EditUserUseCase {
  Future<HelperResponse<User>> updateUser(int id, SendData sendData);
}

class EditUserUseCaseImpl implements EditUserUseCase {
  final EditUserRepository _repository = EditUserRepositoryImpl();

  @override
  Future<HelperResponse<User>> updateUser(int id, SendData sendData) {
    return _repository.updateUser(id, sendData);
  }
}
