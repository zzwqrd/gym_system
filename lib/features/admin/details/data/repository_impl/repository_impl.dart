import '../../../../../../core/resources/helper_respons.dart';
import '../../data/data_source/data_source.dart';
import '../../data/model/model.dart';
import '../../domain/repositories/repository.dart';

class AdminDetailsRepositoryImpl implements AdminDetailsRepository {
  final AdminDetailsDataSource _dataSource = AdminDetailsDataSourceImpl();

  @override
  Future<HelperResponse<Admin>> getAdminById(int id) {
    return _dataSource.getAdminById(id);
  }
}
