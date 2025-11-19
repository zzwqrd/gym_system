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
// backup of previous code before refactoring with TableBuilder
// import 'package:sqflite/sqflite.dart';

// import '../seeder/users_seeder.dart';
// import 'migration.dart';

// class CreateUsersTable extends Migration {
//   @override
//   String get name => '2024_01_01_000002_create_users_table';

//   @override
//   Future<void> up(DatabaseExecutor db) async {
//     await createTable(db, 'users', '''
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       username TEXT UNIQUE NOT NULL,
//       email TEXT UNIQUE NOT NULL,
//       password_hash TEXT NOT NULL,
//       token TEXT UNIQUE NOT NULL,
//       first_name TEXT,
//       last_name TEXT,
//       phone TEXT,
//       avatar TEXT,
//       is_active INTEGER DEFAULT 1,
//       is_verified INTEGER DEFAULT 0,
//       last_login_at TEXT,
//       created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
//       updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))
//     ''');

//     await createIndex(db, 'idx_users_username', 'users', 'username');
//     await createIndex(db, 'idx_users_email', 'users', 'email');
//     await createIndex(db, 'idx_users_active', 'users', 'is_active');

//     // إنشاء trigger لتحديث updated_at
//     await db.execute('''
//       CREATE TRIGGER IF NOT EXISTS update_users_timestamp
//       AFTER UPDATE ON users
//       BEGIN
//         UPDATE users SET updated_at = strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')
//         WHERE id = NEW.id;
//       END
//     ''');
//     await UsersSeeder().run(db);
//   }

//   @override
//   Future<void> down(DatabaseExecutor db) async {
//     await db.execute('DROP TRIGGER IF EXISTS update_users_timestamp');
//     await dropIndex(db, 'idx_users_username');
//     await dropIndex(db, 'idx_users_email');
//     await dropIndex(db, 'idx_users_active');
//     await dropTable(db, 'users');
//   }
// }
