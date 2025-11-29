import '../../../../../core/resources/helper_respons.dart';
import '../../data/model/send_data.dart';
import '../../data/repository_impl/repository_impl.dart';

abstract class LoginUsecase {
  Future<HelperResponse> loginEasy(SendData loginModel);
}

class LoginUsecaseImpl implements LoginUsecase {
  final _loginRepository = LoginRepositoryImpl();

  @override
  Future<HelperResponse> loginEasy(SendData loginModel) {
    return _loginRepository.loginEasy(loginModel);
  }
}
