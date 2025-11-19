import 'package:sqflite/sqflite.dart';

import '../seeder/permissions_seeder.dart';
import 'migration.dart';

class CreatePermissionsTable extends Migration {
  @override
  String get name => '2024_01_01_000004_create_permissions_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await createTable(db, 'permissions', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      permission_name TEXT UNIQUE NOT NULL,
      display_name TEXT NOT NULL,
      description TEXT,
      module TEXT NOT NULL,
      is_active INTEGER DEFAULT 1,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))
    ''');

    // ✅ تعديل اسم العمود في الفهرسة ليتطابق مع permission_name
    await createIndex(
        db, 'idx_permissions_name', 'permissions', 'permission_name');
    await createIndex(db, 'idx_permissions_module', 'permissions', 'module');

    await createTable(db, 'role_permissions', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      role_id INTEGER NOT NULL,
      permission_id INTEGER NOT NULL,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
      FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
      UNIQUE(role_id, permission_id)
    ''');

    await createIndex(
        db, 'idx_role_permissions_role', 'role_permissions', 'role_id');
    await createIndex(db, 'idx_role_permissions_permission', 'role_permissions',
        'permission_id');

    // ✅ تأكد أن PermissionsSeeder يستخدم permission_name وليس name
    await PermissionsSeeder().run(db);
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await dropIndex(db, 'idx_role_permissions_role');
    await dropIndex(db, 'idx_role_permissions_permission');
    await dropTable(db, 'role_permissions');

    await dropIndex(db, 'idx_permissions_name');
    await dropIndex(db, 'idx_permissions_module');
    await dropTable(db, 'permissions');
  }
}
