import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';

abstract class AdminDetailsRepository {
  Future<HelperResponse<Admin>> getAdminById(int id);
}
