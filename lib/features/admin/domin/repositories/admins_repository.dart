import 'package:gym_system/core/database/helper_respons.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';

abstract class AdminsRepository {
  Future<HelperResponse> getAdmins();
  Future<HelperResponse> addAdmin(AdminModel admin);
  Future<HelperResponse> updateAdmin(AdminModel admin);
  Future<HelperResponse> deleteAdmin(int id);
  Future<HelperResponse> getRoles();
}
