import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:croppy/croppy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'config/get_platform.dart' show pt, PlatformInfo, PTExt;
import 'core/bloc_observer.dart';
import 'core/database/db_helper.dart';
import 'core/database/helpers/database_backup_helper.dart';
import 'di/service_locator.dart' as di;

class AppInitializer {
  static final AppInitializer _instance = AppInitializer._internal();
  factory AppInitializer() => _instance;
  AppInitializer._internal();

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    HttpOverrides.global = MyHttpOverrides();
    final temporaryDirectory = await getTemporaryDirectory();

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(temporaryDirectory.path),
    );
    if (kDebugMode) await HydratedBloc.storage.clear();

    try {
      // ✅ 1. استرجاع النسخة الاحتياطية إن وُجدت قبل فتح القاعدة
      await DBBackupManager().restoreBackupIfExists();

      // ✅ 2. تهيئة القاعدة فعليًا (بعد الاسترجاع)
      final db = await DBHelper().database;
      print('✅ Database initialized successfully');
      final data = await db.query('users');

      if (data.isEmpty) {
        print(
          '⚠️ No permissions found, consider creating permissions or checking seeder.',
        );
      } else {
        print('✅ Found $data permission(s) in the database.');
      }
      // ✅ 3. إنشاء نسخة احتياطية جديدة بعد التأكد من جاهزية القاعدة
      await DBBackupManager().createBackup();
    } catch (e, stack) {
      print('❌ Failed to initialize or restore/create backup: $e');
      print('🪵 Stack trace: $stack');
    }
    await _init();

    await di.setupServiceLocator();

    await EasyLocalization.ensureInitialized();

    await ScreenUtil.ensureScreenSize();

    Bloc.observer = AppBlocObserver();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void handleError(Object error, StackTrace stackTrace) {
    log('Unhandled error: $error', error: error, stackTrace: stackTrace);
    return FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'AppInitializer',
        context: ErrorDescription('Unhandled error in AppInitializer'),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

Future<void> _init() async {
  pt = PlatformInfo.getCurrentPlatformType();
  if (pt.isNotWeb) croppyForceUseCassowaryDartImpl = true;
}
