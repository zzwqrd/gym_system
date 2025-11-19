import 'package:sqflite/sqflite.dart';

class MigrationUtils {
  /// حذف عمود مع الاحتفاظ بالبيانات في جدول Backup
  static Future<void> dropColumnSafely({
    required DatabaseExecutor db,
    required String tableName,
    required String columnToRemove,
    required String columnType,
    required String primaryKey, // مثال: 'id'
  }) async {
    final backupTable = '__backup_${tableName}_$columnToRemove';

    // ✅ إنشاء جدول النسخة الاحتياطية
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $backupTable (
        $primaryKey INTEGER PRIMARY KEY,
        $columnToRemove $columnType
      );
    ''');

    // ✅ نسخ البيانات من العمود إلى جدول النسخة الاحتياطية
    await db.execute('''
      INSERT OR REPLACE INTO $backupTable ($primaryKey, $columnToRemove)
      SELECT $primaryKey, $columnToRemove FROM $tableName;
    ''');

    // ✅ إعادة إنشاء الجدول بدون العمود
    await _recreateTableWithoutColumn(
      db: db,
      tableName: tableName,
      columnToRemove: columnToRemove,
    );

    print('🟡 Column `$columnToRemove` was soft-removed and backup saved.');
  }

  /// حذف عمود بدون حفظ نسخة احتياطية
  static Future<void> dropColumnPermanently({
    required DatabaseExecutor db,
    required String tableName,
    required String columnToRemove,
  }) async {
    await _recreateTableWithoutColumn(
      db: db,
      tableName: tableName,
      columnToRemove: columnToRemove,
    );

    print(
        '❌ Column `$columnToRemove` was permanently removed from `$tableName`.');
  }

  /// استرجاع عمود محذوف من النسخة الاحتياطية
  static Future<void> restoreColumnSafely({
    required DatabaseExecutor db,
    required String tableName,
    required String columnName,
    required String columnType,
    required String primaryKey,
  }) async {
    final backupTable = '__backup_${tableName}_$columnName';

    // تأكد أن النسخة الاحتياطية موجودة
    final backupExists = await db.rawQuery('''
      SELECT name FROM sqlite_master 
      WHERE type = 'table' AND name = '$backupTable';
    ''');

    if (backupExists.isEmpty) {
      print('⚠️ No backup found for column `$columnName` in `$tableName`.');
      return;
    }

    // ✅ إضافة العمود
    await db
        .execute('ALTER TABLE $tableName ADD COLUMN $columnName $columnType');

    // ✅ إعادة البيانات من النسخة الاحتياطية
    await db.execute('''
      UPDATE $tableName
      SET $columnName = (
        SELECT $columnName FROM $backupTable
        WHERE $backupTable.$primaryKey = $tableName.$primaryKey
      );
    ''');

    print('✅ Column `$columnName` restored from backup into `$tableName`.');
  }

  /// داخلي: إعادة إنشاء جدول بدون عمود
  static Future<void> _recreateTableWithoutColumn({
    required DatabaseExecutor db,
    required String tableName,
    required String columnToRemove,
  }) async {
    final columnInfo = await db.rawQuery('PRAGMA table_info($tableName)');
    if (columnInfo.isEmpty) {
      throw Exception('❌ Table `$tableName` not found.');
    }

    final columnsToKeep = <String>[];
    final columnDefs = <String>[];

    for (final info in columnInfo) {
      final name = info['name'] as String;
      if (name == columnToRemove) continue;

      columnsToKeep.add(name);

      final type = (info['type'] as String?)?.toUpperCase() ?? 'TEXT';
      final notNull = (info['notnull'] as int?) == 1 ? 'NOT NULL' : '';
      final defVal = info['dflt_value']?.toString();

      final hasInvalidDefault = defVal != null &&
          (defVal.contains('strftime') || defVal.contains('('));
      final defaultClause =
          (defVal != null && !hasInvalidDefault) ? 'DEFAULT $defVal' : '';

      columnDefs.add('$name $type $notNull $defaultClause'.trim());
    }

    final tempTable = '${tableName}_temp';

    await db.execute('''
      CREATE TABLE $tempTable (${columnDefs.join(', ')});
    ''');

    await db.execute('''
      INSERT INTO $tempTable (${columnsToKeep.join(', ')})
      SELECT ${columnsToKeep.join(', ')} FROM $tableName;
    ''');

    await db.execute('DROP TABLE $tableName');

    await db.execute('ALTER TABLE $tempTable RENAME TO $tableName');
  }
}

// import 'package:sqflite/sqflite.dart';
//
// class MigrationUtils {
//   static Future<void> dropColumnSafely({
//     required DatabaseExecutor db,
//     required String tableName,
//     required String columnToRemove,
//   }) async {
//     // 🔍 استخراج جميع أعمدة الجدول
//     final columnInfo = await db.rawQuery('PRAGMA table_info($tableName)');
//     if (columnInfo.isEmpty) {
//       throw Exception('❌ Table `$tableName` not found.');
//     }
//
//     final columnsToKeep = <String>[];
//     final columnDefs = <String>[];
//
//     for (final info in columnInfo) {
//       final name = info['name'] as String;
//       if (name == columnToRemove) continue;
//
//       columnsToKeep.add(name);
//
//       final type = (info['type'] as String?)?.toUpperCase() ?? 'TEXT';
//       final notNull = (info['notnull'] as int?) == 1 ? 'NOT NULL' : '';
//       final defVal = info['dflt_value']?.toString();
//
//       final hasInvalidDefault = defVal != null &&
//           (defVal.contains('strftime') || defVal.contains('('));
//       final defaultClause =
//           (defVal != null && !hasInvalidDefault) ? 'DEFAULT $defVal' : '';
//
//       columnDefs.add('$name $type $notNull $defaultClause'.trim());
//     }
//
//     final tempTable = '${tableName}_temp';
//
//     // ✅ إنشاء الجدول المؤقت بدون العمود
//     await db.execute('''
//       CREATE TABLE $tempTable (${columnDefs.join(', ')});
//     ''');
//
//     // ✅ نقل البيانات بدون العمود المحذوف
//     await db.execute('''
//       INSERT INTO $tempTable (${columnsToKeep.join(', ')})
//       SELECT ${columnsToKeep.join(', ')} FROM $tableName;
//     ''');
//
//     // ✅ حذف الجدول القديم
//     await db.execute('DROP TABLE $tableName');
//
//     // ✅ إعادة تسمية الجدول المؤقت
//     await db.execute('ALTER TABLE $tempTable RENAME TO $tableName');
//
//     print('✅ Column `$columnToRemove` was safely removed from `$tableName`.');
//   }
// }
