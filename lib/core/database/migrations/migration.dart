import 'package:sqflite/sqflite.dart';

abstract class Migration {
  String get name;

  // تم تغيير النوع إلى DatabaseExecutor ليتوافق مع Transaction
  Future<void> up(DatabaseExecutor db);
  Future<void> down(DatabaseExecutor db);

  Future<void> createTable(
    DatabaseExecutor db,
    String table,
    String columns,
  ) async {
    await db.execute('CREATE TABLE IF NOT EXISTS $table ($columns)');
  }

  Future<void> dropTable(DatabaseExecutor db, String table) async {
    await db.execute('DROP TABLE IF EXISTS $table');
  }

  Future<void> addColumn(
    DatabaseExecutor db,
    String table,
    String column,
    String type,
  ) async {
    await db.execute('ALTER TABLE $table ADD COLUMN $column $type');
  }

  Future<void> renameTable(
    DatabaseExecutor db,
    String oldName,
    String newName,
  ) async {
    await db.execute('ALTER TABLE $oldName RENAME TO $newName');
  }

  Future<void> createIndex(
    DatabaseExecutor db,
    String indexName,
    String table,
    String columns,
  ) async {
    await db.execute(
      'CREATE INDEX IF NOT EXISTS $indexName ON $table ($columns)',
    );
  }

  Future<void> dropIndex(DatabaseExecutor db, String indexName) async {
    await db.execute('DROP INDEX IF EXISTS $indexName');
  }

  Future<void> insertData(
    DatabaseExecutor db,
    String table,
    List<Map<String, dynamic>> data,
  ) async {
    for (final row in data) {
      await db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }
}

// abstract class Migration {
//   String get name;
//
//   Future<void> up(Database db);
//   Future<void> down(Database db);
//
//   Future<void> createTable(Database db, String table, String columns) async {
//     await db.execute('CREATE TABLE IF NOT EXISTS $table ($columns)');
//   }
//
//   Future<void> dropTable(Database db, String table) async {
//     await db.execute('DROP TABLE IF EXISTS $table');
//   }
//
//   Future<void> addColumn(Database db, String table, String column, String type) async {
//     await db.execute('ALTER TABLE $table ADD COLUMN $column $type');
//   }
//
//   Future<void> renameTable(Database db, String oldName, String newName) async {
//     await db.execute('ALTER TABLE $oldName RENAME TO $newName');
//   }
//
//   Future<void> createIndex(Database db, String indexName, String table, String columns) async {
//     await db.execute('CREATE INDEX IF NOT EXISTS $indexName ON $table ($columns)');
//   }
//
//   Future<void> dropIndex(Database db, String indexName) async {
//     await db.execute('DROP INDEX IF EXISTS $indexName');
//   }
//
//   Future<void> insertData(Database db, String table, List<Map<String, dynamic>> data) async {
//     for (final row in data) {
//       await db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.ignore);
//     }
//   }
// }
// import 'package:sqflite/sqflite.dart';

// abstract class Migration {
//   String get name;

//   Future<void> up(DatabaseExecutor db);
//   Future<void> down(DatabaseExecutor db);

//   // ========== TABLE OPERATIONS ========== //

//   Future<void> createTable(
//     DatabaseExecutor db,
//     String table,
//     String columns, {
//     bool ifNotExists = true,
//   }) async {
//     final ifNotExistsClause = ifNotExists ? 'IF NOT EXISTS' : '';
//     await db.execute('CREATE TABLE $ifNotExistsClause $table ($columns)');
//   }

//   Future<void> dropTable(
//     DatabaseExecutor db,
//     String table, {
//     bool ifExists = true,
//   }) async {
//     final ifExistsClause = ifExists ? 'IF EXISTS' : '';
//     await db.execute('DROP TABLE $ifExistsClause $table');
//   }

//   Future<void> renameTable(
//     DatabaseExecutor db,
//     String oldName,
//     String newName,
//   ) async {
//     await db.execute('ALTER TABLE $oldName RENAME TO $newName');
//   }

//   Future<void> truncateTable(DatabaseExecutor db, String table) async {
//     await db.execute('DELETE FROM $table');
//   }

//   // ========== COLUMN OPERATIONS ========== //

//   Future<void> addColumn(
//     DatabaseExecutor db,
//     String table,
//     String columnName,
//     String columnType, {
//     String? defaultValue,
//     bool isNotNull = false,
//     bool isUnique = false,
//   }) async {
//     final buffer = StringBuffer();
//     buffer.write('ALTER TABLE $table ADD COLUMN $columnName $columnType');
    
//     if (isNotNull) buffer.write(' NOT NULL');
//     if (isUnique) buffer.write(' UNIQUE');
//     if (defaultValue != null) buffer.write(' DEFAULT $defaultValue');
    
//     await db.execute(buffer.toString());
//   }

//   Future<void> dropColumn(
//     DatabaseExecutor db,
//     String table,
//     String columnName,
//   ) async {
//     // SQLite doesn't support DROP COLUMN directly, need to recreate table
//     await _recreateTableWithoutColumn(db, table, columnName);
//   }

//   Future<void> renameColumn(
//     DatabaseExecutor db,
//     String table,
//     String oldName,
//     String newName,
//     String columnType,
//   ) async {
//     // SQLite doesn't support RENAME COLUMN directly, need to recreate table
//     await _recreateTableWithRenamedColumn(db, table, oldName, newName, columnType);
//   }

//   // ========== INDEX OPERATIONS ========== //

//   Future<void> createIndex(
//     DatabaseExecutor db,
//     String indexName,
//     String table,
//     String columns, {
//     bool ifNotExists = true,
//     bool unique = false,
//   }) async {
//     final ifNotExistsClause = ifNotExists ? 'IF NOT EXISTS' : '';
//     final uniqueClause = unique ? 'UNIQUE' : '';
//     await db.execute(
//       'CREATE $uniqueClause INDEX $ifNotExistsClause $indexName ON $table ($columns)',
//     );
//   }

//   Future<void> dropIndex(
//     DatabaseExecutor db,
//     String indexName, {
//     bool ifExists = true,
//   }) async {
//     final ifExistsClause = ifExists ? 'IF EXISTS' : '';
//     await db.execute('DROP INDEX $ifExistsClause $indexName');
//   }

//   // ========== DATA OPERATIONS ========== //

//   Future<void> insertData(
//     DatabaseExecutor db,
//     String table,
//     List<Map<String, dynamic>> data, {
//     ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.ignore,
//   }) async {
//     final batch = db.batch();
    
//     for (final row in data) {
//       batch.insert(table, row, conflictAlgorithm: conflictAlgorithm);
//     }
    
//     await batch.commit(noResult: true);
//   }

//   Future<void> deleteData(
//     DatabaseExecutor db,
//     String table, {
//     String? where,
//     List<dynamic>? whereArgs,
//   }) async {
//     await db.delete(table, where: where, whereArgs: whereArgs);
//   }

//   Future<void> updateData(
//     DatabaseExecutor db,
//     String table,
//     Map<String, dynamic> values, {
//     String? where,
//     List<dynamic>? whereArgs,
//   }) async {
//     await db.update(table, values, where: where, whereArgs: whereArgs);
//   }

//   // ========== FOREIGN KEY OPERATIONS ========== //

//   Future<void> addForeignKey(
//     DatabaseExecutor db,
//     String table,
//     String column,
//     String referencesTable,
//     String referencesColumn, {
//     String onDelete = 'RESTRICT',
//     String onUpdate = 'RESTRICT',
//   }) async {
//     // Note: SQLite doesn't support ADD FOREIGN KEY directly
//     // This would require table recreation in a real implementation
//     print('Warning: Adding foreign keys requires table recreation in SQLite');
//   }

//   Future<void> enableForeignKeys(DatabaseExecutor db) async {
//     await db.execute('PRAGMA foreign_keys = ON');
//   }

//   // ========== TRIGGER OPERATIONS ========== //

//   Future<void> createTrigger(
//     DatabaseExecutor db,
//     String triggerName,
//     String table,
//     String timing, // BEFORE/AFTER INSERT/UPDATE/DELETE
//     String body, {
//     bool ifNotExists = true,
//   }) async {
//     final ifNotExistsClause = ifNotExists ? 'IF NOT EXISTS' : '';
//     await db.execute('''
//       CREATE TRIGGER $ifNotExistsClause $triggerName
//       $timing ON $table
//       BEGIN
//         $body
//       END
//     ''');
//   }

//   Future<void> dropTrigger(
//     DatabaseExecutor db,
//     String triggerName, {
//     bool ifExists = true,
//   }) async {
//     final ifExistsClause = ifExists ? 'IF EXISTS' : '';
//     await db.execute('DROP TRIGGER $ifExistsClause $triggerName');
//   }

//   // ========== HELPER METHODS ========== //

//   Future<bool> tableExists(DatabaseExecutor db, String tableName) async {
//     final result = await db.rawQuery(
//       "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
//       [tableName],
//     );
//     return result.isNotEmpty;
//   }

//   Future<bool> indexExists(DatabaseExecutor db, String indexName) async {
//     final result = await db.rawQuery(
//       "SELECT name FROM sqlite_master WHERE type='index' AND name=?",
//       [indexName],
//     );
//     return result.isNotEmpty;
//   }

//   Future<List<String>> getTableColumns(DatabaseExecutor db, String tableName) async {
//     final result = await db.rawQuery('PRAGMA table_info($tableName)');
//     return result.map((row) => row['name'] as String).toList();
//   }

//   // ========== PRIVATE HELPER METHODS ========== //

//   Future<void> _recreateTableWithoutColumn(
//     DatabaseExecutor db,
//     String table,
//     String columnToRemove,
//   ) async {
//     final columnInfo = await db.rawQuery('PRAGMA table_info($table)');
//     final columnsToKeep = <String>[];
//     final columnDefs = <String>[];

//     for (final info in columnInfo) {
//       final name = info['name'] as String;
//       if (name == columnToRemove) continue;

//       columnsToKeep.add(name);

//       final type = info['type'] as String;
//       final notNull = (info['notnull'] as int) == 1 ? 'NOT NULL' : '';
//       final defaultValue = info['dflt_value'] != null ? 'DEFAULT ${info['dflt_value']}' : '';
//       final pk = (info['pk'] as int) == 1 ? 'PRIMARY KEY' : '';

//       columnDefs.add('$name $type $notNull $defaultValue $pk'.trim());
//     }

//     final tempTable = '${table}_temp';
    
//     await db.execute('CREATE TABLE $tempTable (${columnDefs.join(', ')})');
//     await db.execute('INSERT INTO $tempTable (${columnsToKeep.join(', ')}) SELECT ${columnsToKeep.join(', ')} FROM $table');
//     await db.execute('DROP TABLE $table');
//     await db.execute('ALTER TABLE $tempTable RENAME TO $table');
//   }

//   Future<void> _recreateTableWithRenamedColumn(
//     DatabaseExecutor db,
//     String table,
//     String oldName,
//     String newName,
//     String newType,
//   ) async {
//     final columnInfo = await db.rawQuery('PRAGMA table_info($table)');
//     final columnDefs = <String>[];

//     for (final info in columnInfo) {
//       final name = info['name'] as String;
//       final type = name == oldName ? newType : info['type'] as String;
//       final notNull = (info['notnull'] as int) == 1 ? 'NOT NULL' : '';
//       final defaultValue = info['dflt_value'] != null ? 'DEFAULT ${info['dflt_value']}' : '';
//       final pk = (info['pk'] as int) == 1 ? 'PRIMARY KEY' : '';

//       final finalName = name == oldName ? newName : name;
//       columnDefs.add('$finalName $type $notNull $defaultValue $pk'.trim());
//     }

//     final tempTable = '${table}_temp';
    
//     await db.execute('CREATE TABLE $tempTable (${columnDefs.join(', ')})');
    
//     final oldColumns = columnInfo.map((info) => info['name'] as String).toList();
//     final newColumns = oldColumns.map((col) => col == oldName ? newName : col).toList();
    
//     await db.execute('INSERT INTO $tempTable (${newColumns.join(', ')}) SELECT ${oldColumns.join(', ')} FROM $table');
//     await db.execute('DROP TABLE $table');
//     await db.execute('ALTER TABLE $tempTable RENAME TO $table');
//   }

//   // ========== TRANSACTION SUPPORT ========== //

//   Future<T> executeInTransaction<T>(
//     DatabaseExecutor db,
//     Future<T> Function() action,
//   ) async {
//     if (db is Transaction) {
//       return await action();
//     } else if (db is Database) {
//       return await db.transaction(action);
//     } else {
//       throw Exception('Unsupported DatabaseExecutor type');
//     }
//   }
// }