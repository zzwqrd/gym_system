class SendData {
  final String email;
  final String password;

  SendData({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
