import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../db_helper.dart';
import '../migration_manager.dart';

class DBBackupManager {
  static final DBBackupManager _instance = DBBackupManager._internal();
  factory DBBackupManager() => _instance;
  DBBackupManager._internal();

  final String _backupFileName = 'backup.db';

  /// إنشاء نسخة احتياطية
  Future<void> createBackup() async {
    try {
      final db = await DBHelper().database;
      final dbPath = db.path;

      final backupDir = await _getBackupDirectory();
      final backupPath = join(backupDir.path, _backupFileName);

      await File(dbPath).copy(backupPath);
      print('✅ Database backup created at: $backupPath');
    } catch (e) {
      print('❌ Failed to create backup: $e');
      rethrow;
    }
  }

  /// استعادة نسخة احتياطية (إن وُجدت) وتشغيل المايجريشن
  Future<void> restoreBackupIfExists() async {
    try {
      final dbPath = await DBHelper().getDatabasePath();
      final backupDir = await _getBackupDirectory();
      final backupPath = join(backupDir.path, _backupFileName);

      final backupFile = File(backupPath);
      if (await backupFile.exists()) {
        print('♻️ Restoring database from backup...');
        await DBHelper().close();
        await backupFile.copy(dbPath);

        final db = await DBHelper().database;

        // تشغيل المايجريشنات الناقصة
        await MigrationManager().initializeMigrationsTable(db);
        final lastBatch = await _getLastBatch(db);
        await MigrationManager().runPendingMigrations(db, batch: lastBatch + 1);

        print('✅ Backup restored and migrations applied.');
      } else {
        print('ℹ️ No backup found to restore.');
      }
    } catch (e) {
      print('❌ Failed to restore backup: $e');
      rethrow;
    }
  }

  /// التحقق من وجود نسخة احتياطية
  Future<bool> backupExists() async {
    try {
      final backupDir = await _getBackupDirectory();
      final backupPath = join(backupDir.path, _backupFileName);
      return File(backupPath).existsSync();
    } catch (_) {
      return false;
    }
  }

  /// يحدد مجلد النسخ الاحتياطي حسب المنصة
  Future<Directory> _getBackupDirectory() async {
    Directory backupDir;

    if (Platform.isAndroid) {
      // Android: نطلب صلاحية التخزين ونحفظ في مجلد خارجي
      await _requestAndroidStoragePermission();
      backupDir = Directory('/storage/emulated/0/GymSystemBackup');
    } else if (Platform.isIOS) {
      // iOS: لا يوجد External Storage - نحفظ في Documents (قابل للمشاركة عبر Files app)
      final docsDir = await getApplicationDocumentsDirectory();
      backupDir = Directory(join(docsDir.path, 'GymSystemBackup'));
    } else if (Platform.isMacOS) {
      // macOS: نحفظ في Documents/GymSystemBackup
      final docsDir = await getApplicationDocumentsDirectory();
      backupDir = Directory(join(docsDir.path, 'GymSystemBackup'));
    } else if (Platform.isWindows) {
      // Windows: نحفظ في Documents/GymSystemBackup
      final docsDir = await getApplicationDocumentsDirectory();
      backupDir = Directory(join(docsDir.path, 'GymSystemBackup'));
    } else if (Platform.isLinux) {
      // Linux: نحفظ في Home/Documents/GymSystemBackup
      final docsDir = await getApplicationDocumentsDirectory();
      backupDir = Directory(join(docsDir.path, 'GymSystemBackup'));
    } else {
      final docsDir = await getApplicationDocumentsDirectory();
      backupDir = Directory(join(docsDir.path, 'GymSystemBackup'));
    }

    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }

    return backupDir;
  }

  /// طلب صلاحيات التخزين على Android فقط
  Future<void> _requestAndroidStoragePermission() async {
    // Android 11+ يحتاج MANAGE_EXTERNAL_STORAGE
    // Android 10 وأقل يحتاج WRITE_EXTERNAL_STORAGE
    PermissionStatus status;

    if (await Permission.manageExternalStorage.isGranted) {
      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) return;
    }

    // Fallback لـ Android 10 وأقل
    status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception(
        'Storage permission not granted. Please allow storage access from app settings.',
      );
    }
  }

  /// إحضار آخر batch من جدول المايجريشن
  Future<int> _getLastBatch(Database db) async {
    try {
      final result = await db.rawQuery(
        'SELECT MAX(batch) as last FROM migrations',
      );
      return result.first['last'] as int? ?? 0;
    } catch (_) {
      return 0;
    }
  }
}
