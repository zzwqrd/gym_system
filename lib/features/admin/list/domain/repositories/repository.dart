import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';

abstract class AdminListRepository {
  Future<HelperResponse<List<Admin>>> getAdmins();
  Future<HelperResponse<void>> deleteAdmin(int id);
}
