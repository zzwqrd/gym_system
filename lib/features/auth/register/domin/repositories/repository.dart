import '../../../../../core/database/helper_respons.dart';
import '../../data/model/send_data.dart';

abstract class RegisterRepository {
  Future<HelperResponse> registerAdmin(RegisterSendData registerModel);
}
