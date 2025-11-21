import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes_fun.dart';
import '../../../../core/routes/navigation.dart';
import '../../../../core/routes/routes.dart';
import 'state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashInitial());

  Future<void> init() async {
    Future.delayed(Duration(seconds: 3), () {
      navigatorKey.currentContext!.push(RouteNames.login);
      emit(SplashInitial());
    });
  }
}
