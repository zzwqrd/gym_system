import 'package:shared_preferences/shared_preferences.dart';
import '../../di/service_locator.dart';

class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();
  factory SharedPrefHelper() => _instance;
  SharedPrefHelper._internal();

  Future<String?> getSecuredToken(String key) async {
    return sl<SharedPreferences>().getString(key);
  }

  Future<void> saveSecuredToken(String key, String value) async {
    await sl<SharedPreferences>().setString(key, value);
  }

  Future<void> deleteUser() async {
    // Implement delete user logic
  }

  Future<void> clearAllSecuredData() async {
    await sl<SharedPreferences>().clear();
  }
}
