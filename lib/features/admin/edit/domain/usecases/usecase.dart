import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../../data/repository_impl/repository_impl.dart';
import '../repositories/repository.dart';

abstract class EditAdminUseCase {
  Future<HelperResponse<Admin>> updateAdmin(int id, SendData sendData);
}

class EditAdminUseCaseImpl implements EditAdminUseCase {
  final EditAdminRepository _repository = EditAdminRepositoryImpl();

  @override
  Future<HelperResponse<Admin>> updateAdmin(int id, SendData sendData) {
    return _repository.updateAdmin(id, sendData);
  }
}
