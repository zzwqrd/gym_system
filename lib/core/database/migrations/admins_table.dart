import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class CreateAdminsTable extends Migration {
  @override
  String get name => '2024_01_01_000003_create_admins_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await createTable(db, 'admins', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      password_hash TEXT NOT NULL,
      token TEXT UNIQUE NOT NULL,
      role_id INTEGER NOT NULL,
      is_active INTEGER DEFAULT 1,
      last_login_at TEXT,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE ON UPDATE CASCADE
    ''');

    await createIndex(db, 'idx_admins_email', 'admins', 'email');
    await createIndex(db, 'idx_admins_role_id', 'admins', 'role_id');
    await createIndex(db, 'idx_admins_active', 'admins', 'is_active');

    // إنشاء trigger لتحديث updated_at
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS update_admins_timestamp
      AFTER UPDATE ON admins
      BEGIN
        UPDATE admins SET updated_at = strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime') 
        WHERE id = NEW.id;
      END
    ''');
    String _hashPassword() {
      final bytes = utf8.encode("1234567");
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    String _generateToken(String email) {
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final raw = '$email-$timestamp';
      final bytes = utf8.encode(raw);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    // إدراج مدير افتراضي
    final superAdminRole =
        await db.query('roles', where: 'name = ?', whereArgs: ['super_admin']);
    if (superAdminRole.isNotEmpty) {
      await insertData(db, 'admins', [
        {
          'name': 'Super Admin',
          'email': 'admin@admin.com',
          'password_hash': _hashPassword(),
          'token': _generateToken('admin@admin.com'),
          'role_id': superAdminRole.first['id'],
          'is_active': 1,
        },
        {
          'name': 'Super Admin 2',
          'email': 's@s.com',
          'password_hash': _hashPassword(),
          'token': _generateToken('admin@admin2.com'),
          'role_id': superAdminRole.first['id'],
          'is_active': 1,
        },
        {
          'name': 'Super Admin 3',
          'email': 'a@a.com',
          'password_hash': _hashPassword(),
          'token': _generateToken('admin@admin3.com'),
          'role_id': superAdminRole.first['id'],
          'is_active': 1,
        },
      ]);
    }
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await db.execute('DROP TRIGGER IF EXISTS update_admins_timestamp');
    await dropIndex(db, 'idx_admins_email');
    await dropIndex(db, 'idx_admins_role_id');
    await dropIndex(db, 'idx_admins_active');
    await dropTable(db, 'admins');
  }
}
