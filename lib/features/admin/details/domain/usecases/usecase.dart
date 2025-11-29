import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/repository_impl/repository_impl.dart';
import '../repositories/repository.dart';

abstract class AdminDetailsUseCase {
  Future<HelperResponse<Admin>> getAdminById(int id);
}

class AdminDetailsUseCaseImpl implements AdminDetailsUseCase {
  final AdminDetailsRepository _repository = AdminDetailsRepositoryImpl();

  @override
  Future<HelperResponse<Admin>> getAdminById(int id) {
    return _repository.getAdminById(id);
  }
}
