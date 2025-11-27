import 'package:flutter/material.dart';
import 'package:gym_system/features/auth/login/presentation/pages/view.dart';
import 'package:gym_system/features/layout/presentation/pages/view.dart';
import 'package:gym_system/features/splash/presentation/pages/view.dart';

import 'routes.dart';

// class AppRoutes {
//   static AppRoutes get init => AppRoutes._internal();
//   String initial = NamedRoutes.i.splash;
//   AppRoutes._internal();
//   Map<String, Widget Function(BuildContext c)> appRoutes = {
//     NamedRoutes.i.test: (c) => const TestView(),
//     NamedRoutes.i.splash: (c) => const SplashView(),
//     // NamedRoutes.i.login: (c) => const LoginView(),
//     // NamedRoutes.i.home: (c) => const HomeScreen(),
//   };
// }

import 'package:gym_system/features/auth/register/presentation/pages/view.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashView());
      case RouteNames.login:
        return MaterialPageRoute<dynamic>(builder: (_) => const LoginView());
      case RouteNames.register:
        return MaterialPageRoute<dynamic>(builder: (_) => const RegisterView());
      case RouteNames.mainLayout:
        return MaterialPageRoute<dynamic>(builder: (_) => const LayoutView());
      default:
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashView());
    }
  }
}
   // case RouteNames.mainLayout
      //   return AppHelperFunctions().fadeTransition(page: const LayoutView());
      // case RouteNames.onboarding:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => const OnboardingScreen(),
      //   );
      // case RouteNames.login:
      //   return MaterialPageRoute<dynamic>(builder: (_) => const LoginScreen());
      // case RouteNames.manageWorkingDays:
      //   return AppHelperFunctions().fadeTransition(
      //     page: const ManageWorkingDaysScreen(),
      //   );
      // case RouteNames.forgotPassword:
      //   return AppHelperFunctions().fadeTransition(
      //     page: const ForgotPasswordScreen(),
      //   );
      // case RouteNames.otp:
      //   final Map<String, dynamic> args =
      //       settings.arguments! as Map<String, dynamic>;
      //   final String phoneNumber = args['phoneNumber'] as String;
      //   final int countryCode = args['countryCode'] as int;
      //   return AppHelperFunctions().fadeTransition(
      //     page: OtpScreen(phoneNumber: phoneNumber, countryCode: countryCode),
      //   );
      // case RouteNames.addNewPassword:
      //   final Map<String, dynamic> args =
      //       settings.arguments! as Map<String, dynamic>;
      //   final int countryCode = args['countryCode'] as int? ?? 1;
      //   return AppHelperFunctions().fadeTransition(
      //     page: AddNewPasswordScreen(countryCode: countryCode),
      //   );
      // case RouteNames.bookingDetails:
      //   final Map<String, dynamic> args =
      //       settings.arguments! as Map<String, dynamic>;
      //   final int bookId = args['bookId'] as int;
      //   final String customerName = args['customerName'] as String? ?? '';

      //   return AppHelperFunctions().fadeTransition(
      //     page: BookingDetailsScreen(
      //       bookId: bookId,
      //       customerName: customerName,
      //     ),
      //   );
      // case RouteNames.transactions:
      //   return AppHelperFunctions().fadeTransition(
      //     page: const TransactionsScreen(),
      //   );
      // case RouteNames.addHolidays:
      //   return AppHelperFunctions().fadeTransition(
      //     page: const AddHolidaysScreen(),
      //   );
