import 'package:sqflite/sqflite.dart';

class TableUtils {
  /// طباعة الجداول التي تحتوي على مفاتيح خارجية تشير إلى الجدول المحدد

  static Future<void> printRelatedForeignKeys({
    required DatabaseExecutor db,
    required String referencedTable,
  }) async {
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%';",
    );

    print(
        '🔍 البحث عن جداول تحتوي على FOREIGN KEY تشير إلى [$referencedTable]...\n');

    for (final table in tables) {
      final tableName = table['name'] as String;
      final foreignKeys =
          await db.rawQuery('PRAGMA foreign_key_list($tableName)');

      for (final fk in foreignKeys) {
        final refTable = fk['table'];
        final from = fk['from'];
        final to = fk['to'];

        if (refTable == referencedTable) {
          print(
              '🔗 [$tableName] يحتوي على FOREIGN KEY من العمود [$from] إلى [$refTable.$to]');
        }
      }
    }
  }

  /// ✅ تغيير اسم جدول مع تحديث علاقات الـ Foreign Key (في الجداول الأخرى)
  static Future<void> renameTableWithForeignKeys({
    required DatabaseExecutor db,
    required String oldName,
    required String newName,
  }) async {
    // 1. إعادة تسمية الجدول نفسه
    await renameTable(db: db, oldName: oldName, newName: newName);

    // 2. البحث عن الجداول التي تحتوي على علاقات تشير إلى الجدول القديم
    final referencingTables = await db.rawQuery('''
    SELECT tbl_name FROM sqlite_master
    WHERE sql LIKE '%REFERENCES $oldName%'
  ''');

    for (final table in referencingTables) {
      final tableName = table['tbl_name'] as String;

      // 3. استخراج تعريف الجدول
      final tableInfo = await db.rawQuery(
        'SELECT sql FROM sqlite_master WHERE type = "table" AND name = ?',
        [tableName],
      );

      if (tableInfo.isEmpty) continue;

      final originalSql = tableInfo.first['sql'] as String;

      // 4. تعديل السطر لتعويض اسم الجدول الجديد في الـ REFERENCES
      final updatedSql = originalSql.replaceAll(
        'REFERENCES $oldName',
        'REFERENCES $newName',
      );

      // 5. إنشاء نسخة جديدة مؤقتة للجدول
      final tempTable = '${tableName}_temp';

      await db.execute(updatedSql.replaceFirst(
          'CREATE TABLE $tableName', 'CREATE TABLE $tempTable'));

      // 6. نقل البيانات إلى الجدول الجديد
      final columns = await db.rawQuery('PRAGMA table_info($tableName)');
      final columnNames =
          columns.map((col) => col['name'] as String).join(', ');

      await db.execute('''
      INSERT INTO $tempTable ($columnNames)
      SELECT $columnNames FROM $tableName
    ''');

      // 7. حذف الجدول القديم وإعادة تسمية المؤقت
      await db.execute('DROP TABLE $tableName');
      await db.execute('ALTER TABLE $tempTable RENAME TO $tableName');

      print(
          '🔁 تم تحديث العلاقات في الجدول `$tableName` إلى الجدول الجديد `$newName`');
    }

    print(
        '✅ تم تغيير اسم الجدول `$oldName` إلى `$newName` وتحديث العلاقات المرتبطة به.');
  }

  /// ✅ إعادة تسمية جدول بدون حذف بيانات
  static Future<void> renameTable({
    required DatabaseExecutor db,
    required String oldName,
    required String newName,
  }) async {
    await db.execute('ALTER TABLE $oldName RENAME TO $newName');
    print('✅ تم تغيير اسم الجدول من `$oldName` إلى `$newName`');
  }

  /// 🟡 حذف جدول مع نسخة احتياطية من البيانات
  static Future<void> backupAndDropTable({
    required DatabaseExecutor db,
    required String tableName,
  }) async {
    final backupTable = '__backup_$tableName';

    // حذف النسخة السابقة لو موجودة
    await db.execute('DROP TABLE IF EXISTS $backupTable');

    // نسخ البيانات إلى النسخة الاحتياطية
    await db.execute('CREATE TABLE $backupTable AS SELECT * FROM $tableName');

    // حذف الجدول الأصلي
    await db.execute('DROP TABLE IF EXISTS $tableName');

    print('🟡 تم حذف الجدول `$tableName` ونسخه إلى `$backupTable`');
  }

  /// 🔁 استرجاع جدول من نسخة احتياطية
  static Future<void> restoreTableFromBackup({
    required DatabaseExecutor db,
    required String tableName,
  }) async {
    final backupTable = '__backup_$tableName';

    // تحقق من وجود النسخة الاحتياطية
    final exists = await db.rawQuery('''
      SELECT name FROM sqlite_master
      WHERE type='table' AND name='$backupTable'
    ''');

    if (exists.isEmpty) {
      print('❌ لا توجد نسخة احتياطية للجدول `$tableName`');
      return;
    }

    // إعادة إنشاء الجدول من النسخة
    await db.execute('CREATE TABLE $tableName AS SELECT * FROM $backupTable');

    print('✅ تم استرجاع الجدول `$tableName` من النسخة الاحتياطية');
  }

  /// ❌ حذف جدول نهائيًا بدون استرجاع
  static Future<void> dropTablePermanently({
    required DatabaseExecutor db,
    required String tableName,
  }) async {
    await db.execute('DROP TABLE IF EXISTS $tableName');
    print('❌ تم حذف الجدول `$tableName` نهائيًا');
  }
}

//import 'package:sqflite/sqflite.dart';
// import '../helpers/table_utils.dart';
// import 'migration.dart';
//
// class DropOldSessionsTable extends Migration {
//   @override
//   String get name => '2025_07_13_000010_drop_old_sessions_table';
//
//   @override
//   Future<void> up(DatabaseExecutor db) async {
//     await TableUtils.backupAndDropTable(
//       db: db,
//       tableName: 'sessions',
//     );
//   }
//
//   @override
//   Future<void> down(DatabaseExecutor db) async {
//     await TableUtils.restoreTableFromBackup(
//       db: db,
//       tableName: 'sessions',
//     );
//   }
// }
