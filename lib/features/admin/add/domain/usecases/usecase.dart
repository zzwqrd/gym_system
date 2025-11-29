import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../../data/repository_impl/repository_impl.dart';
import '../repositories/repository.dart';

abstract class AddAdminUseCase {
  Future<HelperResponse<Admin>> addAdmin(SendData sendData);
}

class AddAdminUseCaseImpl implements AddAdminUseCase {
  final AddAdminRepository _repository = AddAdminRepositoryImpl();

  @override
  Future<HelperResponse<Admin>> addAdmin(SendData sendData) {
    return _repository.addAdmin(sendData);
  }
}
