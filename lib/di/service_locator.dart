import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/login/presentation/controller/controller.dart';
import '../features/auth/register/presentation/controller/controller.dart';
import '../features/layout/presentation/controller/cubit.dart';
import '../features/splash/presentation/controller/controller.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerFactory<SplashController>(() => SplashController());
  sl.registerFactory<LoginController>(() => LoginController());
  sl.registerFactory<RegisterController>(() => RegisterController());
  sl.registerFactory<LayoutCubit>(() => LayoutCubit());
}
