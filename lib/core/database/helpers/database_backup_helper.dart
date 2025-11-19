import 'dart:io';

import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../db_helper.dart';
import '../migration_manager.dart';

class DBBackupManager {
  static final DBBackupManager _instance = DBBackupManager._internal();
  factory DBBackupManager() => _instance;
  DBBackupManager._internal();

  final String _backupFileName = 'backup.db';

  /// إنشاء نسخة احتياطية إلى مجلد خارجي /storage/emulated/0/appSq
  Future<void> createBackup() async {
    try {
      final db = await DBHelper().database;
      final dbPath = db.path;

      final backupDir = await _getExternalBackupDirectory();
      final backupPath = join(backupDir.path, _backupFileName);

      await File(dbPath).copy(backupPath);
      print('✅ Database backup created at: $backupPath');
    } catch (e) {
      print('❌ Failed to create backup: $e');
    }
  }

  /// استعادة نسخة احتياطية (إن وُجدت) وتشغيل المايجريشن
  Future<void> restoreBackupIfExists() async {
    try {
      final dbPath = await DBHelper().getDatabasePath();
      final backupDir = await _getExternalBackupDirectory();
      final backupPath = join(backupDir.path, _backupFileName);

      final backupFile = File(backupPath);
      if (await backupFile.exists()) {
        print('♻️ Restoring database from backup...');
        await backupFile.copy(dbPath);

        await DBHelper().close();
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
    }
  }

  /// مجلد خارجي appSq في storage/emulated/0
  Future<Directory> _getExternalBackupDirectory() async {
    final status = await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      throw Exception('Storage permission not granted');
    }

    final backupDir = Directory('/storage/emulated/0/appSq');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }

  /// إحضار آخر batch من جدول المايجريشن
  Future<int> _getLastBatch(Database db) async {
    try {
      final result =
          await db.rawQuery('SELECT MAX(batch) as last FROM migrations');
      return result.first['last'] as int? ?? 0;
    } catch (_) {
      return 0;
    }
  }
}

// class DBBackupManager {
//   static final DBBackupManager _instance = DBBackupManager._internal();
//   factory DBBackupManager() => _instance;
//   DBBackupManager._internal();
//
//   final String _backupFileName = 'backup.db';
//
//   /// إنشاء نسخة احتياطية
//   Future<void> createBackup() async {
//     try {
//       final db = await DBHelper().database;
//       final dbPath = db.path;
//
//       final backupDir = await _getBackupDirectory();
//       final backupPath = join(backupDir.path, _backupFileName);
//
//       await File(dbPath).copy(backupPath);
//       print('✅ Database backup created at: $backupPath');
//     } catch (e) {
//       print('❌ Failed to create backup: $e');
//     }
//   }
//
//   /// استعادة نسخة احتياطية (إن وُجدت)
//   Future<void> restoreBackupIfExists() async {
//     final dbPath = await DBHelper().getDatabasePath();
//     final backupDir = await _getBackupDirectory();
//     final backupPath = join(backupDir.path, _backupFileName);
//
//     final backupFile = File(backupPath);
//     if (await backupFile.exists()) {
//       print('♻️ Restoring database from backup...');
//       await backupFile.copy(dbPath);
//
//       // إعادة فتح القاعدة لتحديث الاتصال
//       await DBHelper().close();
//       await DBHelper().database;
//
//       // تأكد من تشغيل المايجريشن
//       final db = await DBHelper().database;
//       await BackupManager().runPendingMigrations(db);
//       print('✅ Backup restored and migrations applied.');
//     } else {
//       print('ℹ️ No backup found to restore.');
//     }
//   }
//
//   /// مجلد النسخ الاحتياطي داخل Documents (آمن ولا يتم مسحه عند حذف التطبيق)
//   Future<Directory> _getBackupDirectory() async {
//     final dir = await getApplicationDocumentsDirectory();
//     final backupDir = Directory(join(dir.path, 'db_backups'));
//     if (!await backupDir.exists()) {
//       await backupDir.create(recursive: true);
//     }
//     return backupDir;
//   }
// }

//final backupHelper = DatabaseBackupHelper();
//
// // لعمل نسخة احتياطية:
// await backupHelper.backupToDownloads();
//
// // لاسترجاعها لاحقًا:
// final file = File('/path/to/backup_file.db');
// await backupHelper.restoreFromFile(file);
