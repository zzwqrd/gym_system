class SendData {
  final String? name;
  final String? email;
  final String? password;
  final int? roleId;
  final bool? isActive;

  SendData({this.name, this.email, this.password, this.roleId, this.isActive});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (email != null) map['email'] = email;
    if (password != null) map['password'] = password;
    if (roleId != null) map['role_id'] = roleId;
    if (isActive != null) map['is_active'] = isActive! ? 1 : 0;
    return map;
  }
}
