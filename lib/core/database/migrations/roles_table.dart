import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import 'migration.dart';

class CreateRolesTable extends Migration {
  @override
  String get name => '2024_01_01_000001_create_roles_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await TableBuilder(db, 'roles')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('name', ColumnType.text, isNotNull: true, isUnique: true)
        .addColumn('display_name', ColumnType.text, isNotNull: true)
        .addColumn('is_active', ColumnType.boolean, defaultValue: '1')
        .addColumn(
          'created_at',
          ColumnType.timestamp,
          defaultValue: "CURRENT_TIMESTAMP",
        )
        .addIndex('name', unique: true)
        .addTimestampTrigger()
        .create();

    // إدراج الأدوار الأساسية فقط
    await db.insert('roles', {
      'name': 'super_admin',
      'display_name': 'مدير عام',
      'is_active': 1,
    });
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await TableBuilder(db, 'roles').drop();
  }
}
