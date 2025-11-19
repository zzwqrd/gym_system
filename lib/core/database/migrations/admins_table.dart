import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import 'migration.dart';

class CreateAdminsTable extends Migration {
  @override
  String get name => '2024_01_01_000003_create_admins_table';

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

  @override
  Future<void> up(DatabaseExecutor db) async {
    await TableBuilder(db, 'admins')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('name', ColumnType.text, isNotNull: true)
        .addColumn('email', ColumnType.text, isNotNull: true, isUnique: true)
        .addColumn('password_hash', ColumnType.text, isNotNull: true)
        .addColumn('token', ColumnType.text, isNotNull: true, isUnique: true)
        .addColumn('role_id', ColumnType.integer, isNotNull: true)
        .addForeignKey(
          'role_id',
          'roles',
          'id',
          onDelete: 'CASCADE',
          onUpdate: 'CASCADE',
        )
        .addColumn('is_active', ColumnType.boolean, defaultValue: '1')
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
        .addIndex('email', unique: true)
        .addIndex('role_id')
        .addIndex('is_active')
        .addIndex('token', unique: true)
        .addTimestampTrigger()
        .create();

    // إدراج مدير افتراضي
    await _insertDefaultAdmin(db);
  }

  Future<void> _insertDefaultAdmin(DatabaseExecutor db) async {
    final superAdminRole = await db.query(
      'roles',
      where: 'name = ?',
      whereArgs: ['super_admin'],
    );

    if (superAdminRole.isNotEmpty) {
      final roleId = superAdminRole.first['id'] as int;
      final now = DateTime.now().toIso8601String();

      final defaultAdmins = [
        {
          'name': 'Super Admin',
          'email': 'admin@admin.com',
          'password_hash': _hashPassword(),
          'token': _generateToken('admin@admin.com'),
          'role_id': roleId,
          'is_active': 1,
          'created_at': now,
          'updated_at': now,
        },
        {
          'name': 'Super Admin 2',
          'email': 's@s.com',
          'password_hash': _hashPassword(),
          'token': _generateToken('s@s.com'),
          'role_id': roleId,
          'is_active': 1,
          'created_at': now,
          'updated_at': now,
        },
        {
          'name': 'Super Admin 3',
          'email': 'a@a.com',
          'password_hash': _hashPassword(),
          'token': _generateToken('a@a.com'),
          'role_id': roleId,
          'is_active': 1,
          'created_at': now,
          'updated_at': now,
        },
      ];

      // استخدام Batch للإدراج الجماعي
      final batch = db.batch();
      for (final admin in defaultAdmins) {
        batch.insert('admins', admin);
      }
      await batch.commit(noResult: true);
    }
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    // حذف البيانات أولاً ثم الجدول
    await _deleteDefaultAdmins(db);
    await TableBuilder(db, 'admins').drop();
  }

  Future<void> _deleteDefaultAdmins(DatabaseExecutor db) async {
    await db.delete(
      'admins',
      where: 'email IN (?, ?, ?)',
      whereArgs: ['admin@admin.com', 's@s.com', 'a@a.com'],
    );
  }
}
