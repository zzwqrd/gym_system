import 'package:flutter/material.dart';

import '../../core/utils/ui_extensions/extensions_init.dart';
import '../../gen/assets.gen.dart';

class LoadingBtn extends StatelessWidget {
  const LoadingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAssets.icons.loading.lottie().center;
  }
}

class LoadingApp extends StatelessWidget {
  final double? height;
  const LoadingApp({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 90,
      child: MyAssets.icons.loading
          .lottie(width: 90, height: 90)
          // .withPadding()
          .center,
    );
  }
}

class CustomProgress extends StatelessWidget {
  final double size;
  final double? strokeWidth;
  final Color? color;
  const CustomProgress({
    super.key,
    required this.size,
    this.strokeWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth ?? 2,
              valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
