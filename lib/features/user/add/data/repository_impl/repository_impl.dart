import '../../../../../../core/resources/helper_respons.dart';
import '../../data/data_source/data_source.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../../domain/repositories/repository.dart';

class AddUserRepositoryImpl implements AddUserRepository {
  final AddUserDataSource _dataSource = AddUserDataSourceImpl();

  @override
  Future<HelperResponse<User>> addUser(SendData sendData) {
    return _dataSource.addUser(sendData);
  }
}
