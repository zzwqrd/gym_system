import '../../../../../../core/resources/helper_respons.dart';
import '../../data/model/model.dart';

abstract class UserDetailsRepository {
  Future<HelperResponse<User>> getUserById(int id);
}
