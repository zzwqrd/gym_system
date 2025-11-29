import '../../../../../../core/resources/helper_respons.dart';
import '../../data/data_source/data_source.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../../domain/repositories/repository.dart';

class EditAdminRepositoryImpl implements EditAdminRepository {
  final EditAdminDataSource _dataSource = EditAdminDataSourceImpl();

  @override
  Future<HelperResponse<Admin>> updateAdmin(int id, SendData sendData) {
    return _dataSource.updateAdmin(id, sendData);
  }
}
