import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';

abstract class EditAdminRepository {
  Future<HelperResponse<Admin>> updateAdmin(int id, SendData sendData);
}
