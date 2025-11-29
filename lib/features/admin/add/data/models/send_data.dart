class AdminSendData {
  final String name;
  final String email;

  AdminSendData({required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email};
  }
}
