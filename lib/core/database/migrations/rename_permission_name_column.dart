// import 'package:sqflite/sqflite.dart';
//
// import 'migration.dart';
//
// class RenamePermissionNameColumn extends Migration {
//   @override
//   String get name => '2025_07_11_000001_rename_permission_name_column';
//
//   @override
//   Future<void> up(DatabaseExecutor db) async {
//     await db.execute('''
//       CREATE TABLE permissions_temp (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         permission_name TEXT,
//         is_active INTEGER,
//         created_at TEXT
//       );
//     ''');
//
//     await db.execute('''
//       INSERT INTO permissions_temp (id, permission_name, is_active, created_at)
//       SELECT id, name, is_active, created_at FROM permissions;
//     ''');
//
//     await db.execute('DROP TABLE permissions;');
//     await db.execute('ALTER TABLE permissions_temp RENAME TO permissions;');
//   }
//
//   @override
//   Future<void> down(DatabaseExecutor db) async {
//     await db.execute('''
//       CREATE TABLE permissions_temp (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         is_active INTEGER,
//         created_at TEXT
//       );
//     ''');
//
//     await db.execute('''
//       INSERT INTO permissions_temp (id, name, is_active, created_at)
//       SELECT id, permission_name, is_active, created_at FROM permissions;
//     ''');
//
//     await db.execute('DROP TABLE permissions;');
//     await db.execute('ALTER TABLE permissions_temp RENAME TO permissions;');
//   }
// }
