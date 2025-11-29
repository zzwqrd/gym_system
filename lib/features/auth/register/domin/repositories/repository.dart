import '../../../../../core/resources/helper_respons.dart';
import '../../data/model/send_data.dart';

abstract class RegisterRepository {
  Future<HelperResponse> registerAdmin(RegisterSendData registerModel);
}
