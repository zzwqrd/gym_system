import 'package:flutter/material.dart';
import '../../features/admin/add/presentation/pages/view.dart';
import '../../features/admin/details/data/model/model.dart' as admin_details;
import '../../features/admin/details/presentation/pages/view.dart';
import '../../features/admin/edit/data/model/model.dart' as admin_edit;
import '../../features/admin/edit/presentation/pages/view.dart';
import '../../features/admin/list/presentation/pages/view.dart';
import '../../features/auth/login/presentation/pages/view.dart';
import '../../features/auth/register/presentation/pages/view.dart';
import '../../features/layout/presentation/pages/view.dart';
import '../../features/splash/presentation/pages/view.dart';
import '../../features/user/add/presentation/pages/view.dart';
import '../../features/user/details/data/model/model.dart' as user_details;
import '../../features/user/details/presentation/pages/view.dart';
import '../../features/user/edit/data/model/model.dart' as user_edit;
import '../../features/user/edit/presentation/pages/view.dart';
import '../../features/user/list/presentation/pages/view.dart';
import '../extensions/navigation.dart';
import '../utils/app_helper_functions.dart';
import 'routes.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashView());
      case RouteNames.login:
        return AppHelperFunctions().fadeTransition(page: const LoginView());
      case RouteNames.register:
        return AppHelperFunctions().fadeTransition(page: const RegisterView());
      case RouteNames.mainLayout:
        return AppHelperFunctions().fadeTransition(page: const LayoutView());

      // Admin Features
      case RouteNames.adminList:
        return AppHelperFunctions().fadeTransition(page: const AdminListView());
      case RouteNames.addAdmin:
        return AppHelperFunctions().fadeTransition(page: const AddAdminView());
      case RouteNames.editAdmin:
        final args = settings.args;
        final admin = args['admin'] as admin_edit.Admin;
        return AppHelperFunctions().fadeTransition(
          page: EditAdminView(admin: admin),
        );
      case RouteNames.adminDetails:
        final args = settings.args;
        final adminId = args['adminId'] as int;
        return AppHelperFunctions().fadeTransition(
          page: AdminDetailsView(adminId: adminId),
        );

      // User Features
      case RouteNames.userList:
        return AppHelperFunctions().fadeTransition(page: const UserListView());
      case RouteNames.addUser:
        return AppHelperFunctions().fadeTransition(page: const AddUserView());
      case RouteNames.editUser:
        final args = settings.args;
        final user = args['user'];
        return AppHelperFunctions().fadeTransition(
          page: EditUserView(user: user),
        );
      case RouteNames.userDetails:
        final args = settings.args;
        final userId = args['userId'] as int;
        final user = args['user'];
        return AppHelperFunctions().fadeTransition(
          page: UserDetailsView(userId: userId, user: user),
        );

      default:
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashView());
    }
  }
}
