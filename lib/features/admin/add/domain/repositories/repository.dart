import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';

abstract class AddAdminRepository {
  Future<HelperResponse<Admin>> addAdmin(SendData sendData);
}
