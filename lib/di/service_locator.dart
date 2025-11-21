import 'package:get_it/get_it.dart';

import '../features/test_data/presentation/pages/get_data_user_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerFactory<GetDataUserCubit>(() => GetDataUserCubit());
  // sl.registerFactory<SplashController>(() => SplashController());
  // sl.registerFactory<AuthCubit>(() => AuthCubit());
}
