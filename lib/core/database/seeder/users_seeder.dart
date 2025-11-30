import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';

import 'seeder.dart';

class UsersSeeder implements Seeder {
  @override
  String get name => 'users_seeder';
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
  Future<void> run(DatabaseExecutor db) async {
    final now = DateTime.now().toIso8601String();

    final users = [
      {
        'name': 'Super Admin',
        'email': 'admin@example.com',
        'password_hash': _hashPassword(),
        'phone': '01000000000',
        'national_id': '12345678901234',
        'token': _generateToken('admin@example.com'),
        'avatar': null,
        'is_active': 1,
        'is_verified': 1,
        'last_login_at': now,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Editor User',
        'email': 'editor@example.com',
        'password_hash': _hashPassword(),
        'phone': '01100000000',
        'national_id': '98765432109876',
        'token': _generateToken('editor@example.com'),
        'avatar': null,
        'is_active': 0,
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
  }
}
