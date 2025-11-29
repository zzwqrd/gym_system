import '../../../../../core/resources/helper_respons.dart';
import '../../data/model/send_data.dart';

abstract class LoginRepository {
  Future<HelperResponse> loginEasy(SendData loginModel);
}
