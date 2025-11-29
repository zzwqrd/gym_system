class AdminModel {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;

  AdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['id'] as int,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
