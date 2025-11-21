// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sq_app/core/utils/flash_helper.dart';
//
// import '../../../../core/routes/app_routes_fun.dart';
// import '../../../../core/routes/routes.dart';
// import '../../../../di/service_locator.dart';
// import '../../../auth/sign_in/presentation/controller/controller.dart';
// import 'state.dart';
//
// class SplashController extends Cubit<SplashState> {
//   SplashController() : super(SplashState.initial());
//   final auth = sl<AuthCubit>();
//   Future<void> navigateToNextPage() async {
//     emit(state.copyWith(isLoading: true));
//     final isAuthenticated = auth.state.account;
//
//     Future.delayed(Duration(seconds: 2), () {
//       if (isAuthenticated != null) {
//         ToastHelper().success(
//           msg: 'تم تسجيل الدخول بنجاح',
//           description: 'مرحبًا ${isAuthenticated['name']}',
//         );
//         pushAndRemoveUntil(NamedRoutes.i.home);
//         emit(state.copyWith(isLoading: false));
//       } else {
//         ToastHelper().success(
//           msg: 'مرحبًا بك في التطبيق',
//           description: 'يرجى تسجيل الدخول للمتابعة',
//         );
//         pushAndRemoveUntil(NamedRoutes.i.login);
//         emit(state.copyWith(isLoading: false));
//       }
//
//       emit(state.copyWith(isLoading: false));
//     });
//   }
// }
