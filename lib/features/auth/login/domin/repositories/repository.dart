import '../../../../../core/database/helper_respons.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';

abstract class LoginRepository {
  Future<HelperResponse<Admin>> loginEasy(SendData loginModel);
}
