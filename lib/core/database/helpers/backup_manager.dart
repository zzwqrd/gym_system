import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../db_helper.dart';
import '../migration_manager.dart';

class BackupManager {
  static const _folderName = 'GymSystemBackup';
  static const _backupFileName = 'backup.db';

  /// مسار مجلد النسخة الاحتياطية حسب المنصة
  static Future<Directory> get _backupDirectory async {
    Directory dir;

    if (Platform.isAndroid) {
      await _requestAndroidStoragePermission();
      dir = Directory('/storage/emulated/0/$_folderName');
    } else {
      // iOS, macOS, Windows, Linux -> Documents folder
      final docsDir = await getApplicationDocumentsDirectory();
      dir = Directory(p.join(docsDir.path, _folderName));
    }

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  /// مسار ملف النسخة الاحتياطية
  static Future<String> get backupPath async {
    final dir = await _backupDirectory;
    return p.join(dir.path, _backupFileName);
  }

  /// طلب صلاحيات التخزين على Android فقط
  static Future<void> _requestAndroidStoragePermission() async {
    // نجرب MANAGE_EXTERNAL_STORAGE أولاً (Android 11+)
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) return;

    // Fallback لـ Android 10 وأقل
    final storageStatus = await Permission.storage.request();
    if (!storageStatus.isGranted) {
      throw Exception(
        'Storage permission not granted. Please allow storage access from app settings.',
      );
    }
  }

  /// إنشاء النسخة الاحتياطية
  static Future<void> createBackup() async {
    final dbPath = await DBHelper().databasePath;
    final backup = await backupPath;

    final dbFile = File(dbPath);
    if (await dbFile.exists()) {
      await dbFile.copy(backup);
      print('✅ Backup created at $backup');
    } else {
      print('❌ Database file not found. Cannot create backup.');
    }
  }

  /// استرجاع النسخة إن وُجدت
  Future<void> restoreBackupIfExists() async {
    final dbPath = await DBHelper().databasePath;
    final backup = await backupPath;

    final backupFile = File(backup);
    if (await backupFile.exists()) {
      await DBHelper().close();
      await backupFile.copy(dbPath);
      print('🔄 Backup restored from $backup');

      final db = await DBHelper().database;
      await runPendingMigrations(db);
    } else {
      print('ℹ️ No backup found to restore.');
    }
  }

  /// تشغيل المايجريشنات الناقصة
  Future<void> runPendingMigrations(Database db) async {
    await MigrationManager().initializeMigrationsTable(db);
    final lastBatch = await _getLastBatch(db);
    await MigrationManager().runPendingMigrations(db, batch: lastBatch + 1);
  }

  static Future<int> _getLastBatch(Database db) async {
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
