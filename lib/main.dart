import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'app_initializer.dart';
import 'core/ui/loger.dart';

final logger = LoggerDebug(headColor: LogColors.green);

Future<void> main() async {
  final initializer = AppInitializer();

  await runZonedGuarded(() async {
    logger.green("اللهم صلي وسلم وبارك على سيدنا محمد وعلى آله وصحبه 💕");
    await initializer.initialize();

    runApp(
      EasyLocalization(
        path: 'assets/lang',
        saveLocale: true,
        startLocale: const Locale('ar'),
        fallbackLocale: const Locale('en'),
        supportedLocales: const [Locale('ar'), Locale('en')],
        child: const MyApp(),
      ),
    );
  }, initializer.handleError);
}
