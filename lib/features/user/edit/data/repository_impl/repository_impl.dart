import '../../../../../../core/resources/helper_respons.dart';
import '../../data/data_source/data_source.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../../domain/repositories/repository.dart';

class EditUserRepositoryImpl implements EditUserRepository {
  final EditUserDataSource _dataSource = EditUserDataSourceImpl();

  @override
  Future<HelperResponse<User>> updateUser(int id, SendData sendData) {
    return _dataSource.updateUser(id, sendData);
  }
}
