import '../../../../../../core/resources/helper_respons.dart';
import '../../data/data_source/data_source.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../../domain/repositories/repository.dart';

class AddAdminRepositoryImpl implements AddAdminRepository {
  final AddAdminDataSource _dataSource = AddAdminDataSourceImpl();

  @override
  Future<HelperResponse<Admin>> addAdmin(SendData sendData) {
    return _dataSource.addAdmin(sendData);
  }
}
