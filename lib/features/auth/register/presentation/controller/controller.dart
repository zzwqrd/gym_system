import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../commonWidget/toast_helper.dart';
import '../../../../../core/routes/app_routes_fun.dart';
import '../../../../../core/routes/navigation.dart';

import '../../../../../core/utils/enums.dart';
import '../../../../../di/service_locator.dart';
import '../../data/model/send_data.dart';
import '../../domin/usecases/usecase.dart';
import 'state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(RegisterState());
  final formKey = GlobalKey<FormState>();
  final pref = sl<SharedPreferences>();
  final RegisterUsecase _registerUseCase = RegisterUsecaseImpl();

  RegisterSendData registerModel = RegisterSendData(
    name: "",
    email: "",
    password: "",
  );

  Future<void> registerAdmin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState?.save();
    emit(state.copyWith(requestState: RequestState.loading));

    final response = await _registerUseCase.registerAdmin(registerModel);

    response.when(
      success: (admin) async {
        // في حالة التسجيل، قد لا نحتاج لتخزين التوكن مباشرة إذا كان المطلوب تسجيل دخول بعد التسجيل
        // لكن هنا سنفترض أنه يسجل دخول مباشرة
        // pref.setString("admin_token", admin.token);

        // نظهر رسالة نجاح
        FlashHelper.showToast(response.message, type: MessageTypeTost.success);

        // العودة لصفحة اللوجن أو الصفحة الرئيسية حسب المتطلبات
        // هنا سنعود للخلف (للوجن)
        navigatorKey.currentContext!.pop();

        // نغير الحالة لنجاح
        emit(state.copyWith(requestState: RequestState.done));
      },
      error: (message, errorType) {
        // نظهر رسالة خطأ
        FlashHelper.showToast(message, type: MessageTypeTost.fail);

        // نغير الحالة لخطأ
        emit(state.copyWith(requestState: RequestState.error));
      },
    );
  }
}
