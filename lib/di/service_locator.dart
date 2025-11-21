import 'package:get_it/get_it.dart';

import '../features/splash/presentation/controller/controller.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerFactory<SplashController>(() => SplashController());

  // sl.registerFactory<GetDataUserCubit>(() => GetDataUserCubit());

  // sl.registerFactory<AuthCubit>(() => AuthCubit());
}
