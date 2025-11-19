import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class CreateRolesTable extends Migration {
  @override
  String get name => '2024_01_01_000001_create_roles_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await createTable(db, 'roles', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT UNIQUE NOT NULL,
      display_name TEXT NOT NULL,
      description TEXT,
      is_active INTEGER DEFAULT 1,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))
    ''');

    await createIndex(db, 'idx_roles_name', 'roles', 'name');
    await createIndex(db, 'idx_roles_active', 'roles', 'is_active');

    // إدراج الأدوار الأساسية
    await insertData(db, 'roles', [
      {
        'name': 'super_admin',
        'display_name': 'مدير عام',
        'description': 'صلاحيات كاملة للنظام',
        'is_active': 1,
      },
      {
        'name': 'admin',
        'display_name': 'مدير',
        'description': 'صلاحيات إدارية محدودة',
        'is_active': 1,
      },
      {
        'name': 'user',
        'display_name': 'مستخدم',
        'description': 'مستخدم عادي',
        'is_active': 1,
      },
    ]);
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await dropIndex(db, 'idx_roles_name');
    await dropIndex(db, 'idx_roles_active');
    await dropTable(db, 'roles');
  }
}

// class CreateRolesTable extends Migration {
//   @override
//   String get name => '2024_01_01_000001_create_roles_table';
//
//   @override
//   Future<void> up(Database db) async {
//     await createTable(db, 'roles', '''
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       name TEXT UNIQUE NOT NULL,
//       display_name TEXT NOT NULL,
//       description TEXT,
//       is_active INTEGER DEFAULT 1,
//       created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
//       updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))
//     ''');
//
//     await createIndex(db, 'idx_roles_name', 'roles', 'name');
//     await createIndex(db, 'idx_roles_active', 'roles', 'is_active');
//
//     // إدراج الأدوار الأساسية
//     await insertData(db, 'roles', [
//       {
//         'name': 'super_admin',
//         'display_name': 'مدير عام',
//         'description': 'صلاحيات كاملة للنظام',
//         'is_active': 1,
//       },
//       {
//         'name': 'admin',
//         'display_name': 'مدير',
//         'description': 'صلاحيات إدارية محدودة',
//         'is_active': 1,
//       },
//       {
//         'name': 'user',
//         'display_name': 'مستخدم',
//         'description': 'مستخدم عادي',
//         'is_active': 1,
//       },
//     ]);
//   }
//
//   @override
//   Future<void> down(Database db) async {
//     await dropIndex(db, 'idx_roles_name');
//     await dropIndex(db, 'idx_roles_active');
//     await dropTable(db, 'roles');
//   }
// }
