import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/ui/ui_extensions/box_extensions.dart';
import 'package:gym_system/core/ui/ui_extensions/complete_flutter_extensions.dart'
    show StringExtensions, NumExtensions;

import '../../../../di/service_locator.dart';
import '../controller/controller.dart';
import '../controller/state.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = sl<SplashController>();
    return BlocBuilder<SplashController, SplashState>(
      bloc: controller..init(),
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              CircularProgressIndicator(),
              18.verticalSpace,
              "... loading".h1().center,
            ],
          ),
        );
      },
    );
  }
}
