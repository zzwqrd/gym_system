import 'package:flutter/material.dart';
import 'package:gym_system/core/ui/ui_extensions/box_extensions.dart';
import 'package:gym_system/core/ui/ui_extensions/complete_flutter_extensions.dart'
    show StringExtensions, NumExtensions;

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
