import '../../../../../core/resources/helper_respons.dart';
import '../../domin/repositories/repository.dart';
import '../data_source/data_source.dart';
import '../model/send_data.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final _registerDataSource = RegisterDataSourceImpl();

  @override
  Future<HelperResponse> registerAdmin(RegisterSendData registerModel) {
    return _registerDataSource.registerAdmin(registerModel);
  }
}
