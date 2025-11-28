import 'package:gym_system/core/database/helper_respons.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';
import 'package:gym_system/features/admin/data/repository_impl/admins_repository_impl.dart';

abstract class AdminsUseCase {
  Future<HelperResponse> getAdmins();
  Future<HelperResponse> addAdmin(AdminModel admin);
  Future<HelperResponse> updateAdmin(AdminModel admin);
  Future<HelperResponse> deleteAdmin(int id);
  Future<HelperResponse> getRoles();
}

class AdminsUseCaseImpl implements AdminsUseCase {
  final _adminsRepository = AdminsRepositoryImpl();

  @override
  Future<HelperResponse> getAdmins() {
    return _adminsRepository.getAdmins();
  }

  @override
  Future<HelperResponse> addAdmin(AdminModel admin) {
    return _adminsRepository.addAdmin(admin);
  }

  @override
  Future<HelperResponse> updateAdmin(AdminModel admin) {
    return _adminsRepository.updateAdmin(admin);
  }

  @override
  Future<HelperResponse> deleteAdmin(int id) {
    return _adminsRepository.deleteAdmin(id);
  }

  @override
  Future<HelperResponse> getRoles() {
    return _adminsRepository.getRoles();
  }
}
