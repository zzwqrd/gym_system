class AdminModel {
  final int? id;
  final String name;
  final String email;
  final String? passwordHash;
  final String? token;
  final int roleId;
  final bool isActive;
  final DateTime? lastLoginAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AdminModel({
    this.id,
    required this.name,
    required this.email,
    this.passwordHash,
    this.token,
    required this.roleId,
    this.isActive = true,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      email: json['email'] as String,
      passwordHash: json['password_hash'] as String?,
      token: json['token'] as String?,
      roleId: json['role_id'] as int,
      isActive: (json['is_active'] as int?) == 1,
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password_hash': passwordHash,
      'token': token,
      'role_id': roleId,
      'is_active': isActive ? 1 : 0,
      'last_login_at': lastLoginAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  AdminModel copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    String? token,
    int? roleId,
    bool? isActive,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      token: token ?? this.token,
      roleId: roleId ?? this.roleId,
      isActive: isActive ?? this.isActive,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
