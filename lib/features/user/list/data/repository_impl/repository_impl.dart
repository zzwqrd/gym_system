import '../../../../../../core/resources/helper_respons.dart';
import '../../data/data_source/data_source.dart';
import '../../data/model/model.dart';
import '../../domain/repositories/repository.dart';

class UserListRepositoryImpl implements UserListRepository {
  final UserListDataSource _dataSource = UserListDataSourceImpl();

  @override
  Future<HelperResponse<List<User>>> getUsers() {
    return _dataSource.getUsers();
  }

  @override
  Future<HelperResponse<void>> deleteUser(int id) {
    return _dataSource.deleteUser(id);
  }
}
