import '../../../../../core/database/helper_respons.dart';
import '../../domin/repositories/repository.dart';
import '../data_source/data_source.dart';
import '../model/send_data.dart';

class LoginRepositoryImpl implements LoginRepository {
  final _loginDataSource = LoginDataSourceImpl();

  @override
  Future<HelperResponse> loginEasy(SendData loginModel) {
    return _loginDataSource.loginEasy(loginModel);
  }
}
