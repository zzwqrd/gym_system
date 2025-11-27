// lib/core/models/admin_model.dart
class Admin {
  final int id;
  final String name;
  final String email;
  final String passwordHash;
  final String token;
  final int roleId;
  final bool isActive;
  final DateTime? lastLoginAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.token,
    required this.roleId,
    required this.isActive,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      passwordHash: map['password_hash'] as String,
      token: map['token'] as String,
      roleId: map['role_id'] as int,
      isActive: (map['is_active'] as int) == 1,
      lastLoginAt: map['last_login_at'] != null
          ? DateTime.parse(map['last_login_at'] as String)
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password_hash': passwordHash,
      'token': token,
      'role_id': roleId,
      'is_active': isActive ? 1 : 0,
      'last_login_at': lastLoginAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Admin(id: $id, name: $name, email: $email, roleId: $roleId, isActive: $isActive)';
  }
}
