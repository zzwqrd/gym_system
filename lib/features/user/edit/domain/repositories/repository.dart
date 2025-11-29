import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';

abstract class EditUserRepository {
  Future<HelperResponse<User>> updateUser(int id, SendData sendData);
}
