import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';

import 'seeder.dart';

class AddDefaultEditorUserSeeder extends Seeder {
  @override
  String get name => 'add_default_editor_user_seeder';

  @override
  Future<void> run(DatabaseExecutor db) async {
    final now = DateTime.now().toIso8601String();
    final password = _hashPassword("1234567");
    final users = [
      {
        'username': 'z',
        'email': 'z@z.com',
        'password_hash': password,
        'first_name': 'Editorw',
        'last_name': 'Users',
        'phone': '011000000003',
        'avatar': null,
        'is_active': 1,
        'is_verified': 1,
        'last_login_at': now,
        'created_at': now,
        'updated_at': now,
      },
      {
        'username': 'zc',
        'email': 'c@z.com',
        'password_hash': password,
        'first_name': 'Editorw',
        'last_name': 'Userw',
        'phone': '011000000003',
        'avatar': null,
        'is_active': 1,
        'is_verified': 1,
        'last_login_at': now,
        'created_at': now,
        'updated_at': now,
      },
      {
        'username': 'zdsad',
        'email': 'd@zsd.com',
        'password_hash': password,
        'first_name': 'Editorsd',
        'last_name': 'Usesadr',
        'phone': '01100000000',
        'avatar': null,
        'is_active': 1,
        'is_verified': 1,
        'last_login_at': now,
        'created_at': now,
        'updated_at': now,
      },
    ];
    for (var user in users) {
      await db.insert(
        'users',
        user,
        conflictAlgorithm: ConflictAlgorithm.ignore, // ما يدخلش مرتين لو موجود
      );
    }
    // await db.insert(
    //   'users',
    //   {
    //     'username': 'editoraa',
    //     'email': 'editoraaa@example.com',
    //     'password_hash': password,
    //     'first_name': 'Editor',
    //     'last_name': 'User',
    //     'phone': '01100000000',
    //     'avatar': null,
    //     'is_active': 1,
    //     'is_verified': 1,
    //     'last_login_at': now,
    //     'created_at': now,
    //     'updated_at': now,
    //   },
    //   conflictAlgorithm: ConflictAlgorithm.ignore,
    // );
  }

  String _hashPassword(String raw) {
    final bytes = utf8.encode(raw);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
