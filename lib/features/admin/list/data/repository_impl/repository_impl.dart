import '../../../../../../core/resources/helper_respons.dart';
import '../../data/data_source/data_source.dart';
import '../../data/model/model.dart';
import '../../domain/repositories/repository.dart';

class AdminListRepositoryImpl implements AdminListRepository {
  final AdminListDataSource _dataSource = AdminListDataSourceImpl();

  @override
  Future<HelperResponse<List<Admin>>> getAdmins() {
    return _dataSource.getAdmins();
  }

  @override
  Future<HelperResponse<void>> deleteAdmin(int id) {
    return _dataSource.deleteAdmin(id);
  }
}
