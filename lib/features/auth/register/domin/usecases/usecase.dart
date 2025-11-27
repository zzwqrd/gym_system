import '../../../../../core/database/helper_respons.dart';
import '../../data/model/send_data.dart';
import '../../data/repository_impl/repository_impl.dart';

abstract class RegisterUsecase {
  Future<HelperResponse> registerAdmin(RegisterSendData registerModel);
}

class RegisterUsecaseImpl implements RegisterUsecase {
  final _registerRepository = RegisterRepositoryImpl();

  @override
  Future<HelperResponse> registerAdmin(RegisterSendData registerModel) {
    return _registerRepository.registerAdmin(registerModel);
  }
}
