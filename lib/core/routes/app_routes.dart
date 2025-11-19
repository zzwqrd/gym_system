import 'package:flutter/material.dart';

import '../../features/splash/presentation/pages/view.dart';
import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.i.splash;
  AppRoutes._internal();
  Map<String, Widget Function(BuildContext c)> appRoutes = {
    NamedRoutes.i.splash: (c) => const SplashView(),
    // NamedRoutes.i.login: (c) => const LoginView(),
    // NamedRoutes.i.home: (c) => const HomeScreen(),
  };
}
