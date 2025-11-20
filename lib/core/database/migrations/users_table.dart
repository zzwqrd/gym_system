import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import '../seeder/users_seeder.dart';
import 'migration.dart';

// after refactoring with TableBuilder
class CreateUsersTable extends Migration {
  @override
  String get name {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy_MM_dd_HHmmss');
    return '${formatter.format(now)}_create_users_table';
  }

  @override
  Future<void> up(DatabaseExecutor db) async {
    await TableBuilder(db, 'users')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('username', ColumnType.text, isNotNull: true, isUnique: true)
        .addColumn('email', ColumnType.text, isNotNull: true, isUnique: true)
        .addColumn('password_hash', ColumnType.text, isNotNull: true)
        .addColumn('token', ColumnType.text, isNotNull: true, isUnique: true)
        .addColumn('first_name', ColumnType.text)
        .addColumn('last_name', ColumnType.text)
        .addColumn('phone', ColumnType.text)
        .addColumn('avatar', ColumnType.text)
        .addColumn('is_active', ColumnType.boolean, defaultValue: '1')
        .addColumn('is_verified', ColumnType.boolean, defaultValue: '0')
        .addColumn('last_login_at', ColumnType.timestamp)
        .addColumn(
          'created_at',
          ColumnType.timestamp,
          defaultValue: "(strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))",
        )
        .addColumn(
          'updated_at',
          ColumnType.timestamp,
          defaultValue: "(strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))",
        )
        .addIndex('username')
        .addIndex('email', unique: true)
        .addIndex('is_active')
        .addIndex('token', unique: true)
        .addTimestampTrigger()
        .create();

    await UsersSeeder().run(db);
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await TableBuilder(db, 'users').drop();
  }
}
