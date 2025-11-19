import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../db_helper.dart';
import '../migration_manager.dart';

class BackupManager {
  static const _folderName = 'MyAppBackup';
  static const _backupFileName = 'backup.db';

  /// مسار النسخة في /storage/emulated/0/MyAppBackup/backup.db
  static Future<String> get backupPath async {
    final dir = Directory('/storage/emulated/0/$_folderName');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return p.join(dir.path, _backupFileName);
  }

  /// طلب صلاحية
  static Future<void> _ensurePermission() async {
    final status = await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      throw Exception('🚫 Storage permission not granted.');
    }
  }

  /// إنشاء النسخة الاحتياطية
  static Future<void> createBackup() async {
    await _ensurePermission();
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
    await _ensurePermission();
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
      final result =
          await db.rawQuery('SELECT MAX(batch) as last FROM migrations');
      return result.first['last'] as int? ?? 0;
    } catch (_) {
      return 0;
    }
  }
}
