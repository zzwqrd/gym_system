class SendData {
  final String? name;
  final String? email;
  final String? phone;
  final String? nationalId;
  final String? password;
  final bool? isActive;

  SendData({
    this.name,
    this.email,
    this.phone,
    this.nationalId,
    this.password,
    this.isActive,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (email != null) map['email'] = email;
    if (phone != null) map['phone'] = phone;
    if (nationalId != null) map['national_id'] = nationalId;
    if (password != null) map['password'] = password;
    if (isActive != null) map['is_active'] = isActive! ? 1 : 0;
    return map;
  }
}
