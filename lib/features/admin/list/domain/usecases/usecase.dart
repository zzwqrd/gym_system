import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/repository_impl/repository_impl.dart';
import '../repositories/repository.dart';

abstract class AdminListUseCase {
  Future<HelperResponse<List<Admin>>> getAdmins();
  Future<HelperResponse<void>> deleteAdmin(int id);
}

class AdminListUseCaseImpl implements AdminListUseCase {
  final AdminListRepository _repository = AdminListRepositoryImpl();

  @override
  Future<HelperResponse<List<Admin>>> getAdmins() {
    return _repository.getAdmins();
  }

  @override
  Future<HelperResponse<void>> deleteAdmin(int id) {
    return _repository.deleteAdmin(id);
  }
}
