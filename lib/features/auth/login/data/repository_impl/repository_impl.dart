import '../../../../../core/database/helper_respons.dart';
import '../../domin/repositories/repository.dart';
import '../data_source/data_source.dart';
import '../model/model.dart';
import '../model/send_data.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource = LoginDataSourceImpl();

  @override
  Future<HelperResponse<Admin>> loginEasy(SendData loginModel) {
    return _loginDataSource.loginEasy(loginModel);
  }
}
