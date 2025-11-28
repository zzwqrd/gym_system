class UserModel {
  final int? id;
  final String username;
  final String email;
  final String? passwordHash;
  final String? token;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatar;
  final bool isActive;
  final bool isVerified;
  final DateTime? lastLoginAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    this.passwordHash,
    this.token,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatar,
    this.isActive = true,
    this.isVerified = false,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      username: json['username'] as String,
      email: json['email'] as String,
      passwordHash: json['password_hash'] as String?,
      token: json['token'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      isActive: (json['is_active'] as int?) == 1,
      isVerified: (json['is_verified'] as int?) == 1,
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
      'username': username,
      'email': email,
      'password_hash': passwordHash,
      'token': token,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'avatar': avatar,
      'is_active': isActive ? 1 : 0,
      'is_verified': isVerified ? 1 : 0,
      'last_login_at': lastLoginAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    String? username,
    String? email,
    String? passwordHash,
    String? token,
    String? firstName,
    String? lastName,
    String? phone,
    String? avatar,
    bool? isActive,
    bool? isVerified,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      token: token ?? this.token,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
