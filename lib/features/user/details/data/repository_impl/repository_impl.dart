import '../../../../../../core/resources/helper_respons.dart';
import '../../data/data_source/data_source.dart';
import '../../data/model/model.dart';
import '../../domain/repositories/repository.dart';

class UserDetailsRepositoryImpl implements UserDetailsRepository {
  final UserDetailsDataSource _dataSource = UserDetailsDataSourceImpl();

  @override
  Future<HelperResponse<User>> getUserById(int id) {
    return _dataSource.getUserById(id);
  }
}
