import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import '../seeder/permissions_seeder.dart';
import 'migration.dart';

class CreatePermissionsTable extends Migration {
  @override
  String get name => '2024_01_01_000004_create_permissions_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    // جدول الصلاحيات
    await TableBuilder(db, 'permissions')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn(
          'permission_name',
          ColumnType.text,
          isNotNull: true,
          isUnique: true,
        )
        .addColumn('display_name', ColumnType.text, isNotNull: true)
        .addColumn('description', ColumnType.text)
        .addColumn('module', ColumnType.text, isNotNull: true)
        .addColumn('is_active', ColumnType.boolean, defaultValue: '1')
        .addColumn(
          'created_at',
          ColumnType.timestamp,
          defaultValue: "CURRENT_TIMESTAMP",
        )
        .addColumn(
          'updated_at',
          ColumnType.timestamp,
          defaultValue: "CURRENT_TIMESTAMP",
        )
        .addIndex('permission_name', unique: true)
        .addIndex('module')
        .addIndex('is_active')
        .addTimestampTrigger()
        .create();

    // جدول صلاحيات الأدوار
    await TableBuilder(db, 'role_permissions')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('role_id', ColumnType.integer, isNotNull: true)
        .addColumn('permission_id', ColumnType.integer, isNotNull: true)
        .addColumn(
          'created_at',
          ColumnType.timestamp,
          defaultValue: "CURRENT_TIMESTAMP",
        )
        .addIndex('role_id')
        .addIndex('permission_id')
        .addCompositeIndex(['role_id', 'permission_id'], unique: true)
        .create();

    // إضافة البيانات الأساسية
    await PermissionsSeeder().run(db);
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    // await PermissionsSeeder().rollback(db);
    await TableBuilder(db, 'role_permissions').drop();
    await TableBuilder(db, 'permissions').drop();
  }
}
