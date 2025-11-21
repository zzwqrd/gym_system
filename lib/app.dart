import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_system/core/routes/routes.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/app_routes_fun.dart';
import 'core/ui/phoneix.dart';
import 'core/ui/unfucs.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, Widget? child) {
        return MaterialApp(
          title: 'SQLite Manager',
          initialRoute: RouteNames.splash,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          navigatorKey: navigatorKey,
          navigatorObservers: <NavigatorObserver>[routeObserver],
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            // textTheme: AppTypography.light(context).toTextTheme(),
          ),
          darkTheme: ThemeData(
            // textTheme: AppTypography.dark(context).toTextTheme(),
          ),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
              PointerDeviceKind.invertedStylus,
            },
          ),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          builder: (context, child) {
            return _AppBuilder(child: child ?? const SizedBox.shrink());
          },
        );
      },
    );
  }
}

class _AppBuilder extends StatelessWidget {
  final Widget? child;

  const _AppBuilder({this.child});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return Scaffold(
        appBar: AppBar(title: Text('error_title'.tr()), elevation: 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('error_message'.tr()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Phoenix.rebirth(context),
                child: Text('retry'.tr()),
              ),
            ],
          ),
        ),
      );
    };
    return MediaQuery(
      data: mediaQuery.copyWith(
        textScaler: TextScaler.linear(1.sp.clamp(1.0, 1.5)),
        accessibleNavigation: mediaQuery.accessibleNavigation,
        boldText: mediaQuery.boldText,
        highContrast: mediaQuery.highContrast,
        padding: mediaQuery.padding,
        viewInsets: mediaQuery.viewInsets,
        devicePixelRatio: mediaQuery.devicePixelRatio,
        alwaysUse24HourFormat: true,
        platformBrightness: Theme.of(context).brightness,
        disableAnimations: mediaQuery.disableAnimations,
        gestureSettings: const DeviceGestureSettings(touchSlop: 10.0),
      ),
      child: KeyedSubtree(
        key: ValueKey(
          'app_${context.locale}_${mediaQuery.accessibleNavigation}',
        ),
        child: Phoenix(child: Unfocus(child: child ?? const SizedBox.shrink())),
      ),
    );
  }
}
