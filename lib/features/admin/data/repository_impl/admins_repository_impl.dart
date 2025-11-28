import 'package:gym_system/core/database/helper_respons.dart';
import 'package:gym_system/features/admin/data/data_source/admins_data_source.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';
import 'package:gym_system/features/admin/domin/repositories/admins_repository.dart';

class AdminsRepositoryImpl implements AdminsRepository {
  final _adminsDataSource = AdminsDataSourceImpl();

  @override
  Future<HelperResponse> getAdmins() {
    return _adminsDataSource.getAdmins();
  }

  @override
  Future<HelperResponse> addAdmin(AdminModel admin) {
    return _adminsDataSource.addAdmin(admin);
  }

  @override
  Future<HelperResponse> updateAdmin(AdminModel admin) {
    return _adminsDataSource.updateAdmin(admin);
  }

  @override
  Future<HelperResponse> deleteAdmin(int id) {
    return _adminsDataSource.deleteAdmin(id);
  }

  @override
  Future<HelperResponse> getRoles() {
    return _adminsDataSource.getRoles();
  }
}
