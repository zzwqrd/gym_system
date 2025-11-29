import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../../data/repository_impl/repository_impl.dart';
import '../repositories/repository.dart';

abstract class AddUserUseCase {
  Future<HelperResponse<User>> addUser(SendData sendData);
}

class AddUserUseCaseImpl implements AddUserUseCase {
  final AddUserRepository _repository = AddUserRepositoryImpl();

  @override
  Future<HelperResponse<User>> addUser(SendData sendData) {
    return _repository.addUser(sendData);
  }
}
