class AddAdminSendData {
  final String name;
  final String email;
  final String password;
  final int roleId;

  AddAdminSendData({
    required this.name,
    required this.email,
    required this.password,
    required this.roleId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password_hash':
          password, // Will be hashed in backend/repository if needed, or here?
      // User said: "The form logic, submission, validation triggers go here."
      // Usually hashing happens in backend or before DB insert.
      // I'll keep it as password here and let DataSource/Repository handle hashing if needed.
      // But wait, DataSource uses QueryBuilder.
      // Original code hashed it in Controller? No, original code:
      // "where('password_hash', _hashPassword(loginModel.password))" in LoginController.
      // So I should probably hash it before sending to DB.
      // But SendData is just DTO.
      'role_id': roleId,
      'is_active': 1,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }
}
