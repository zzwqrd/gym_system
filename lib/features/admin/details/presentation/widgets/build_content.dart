import 'package:flutter/material.dart';

import '../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../data/model/model.dart';
import 'build_detail_item.dart';

class AdminDetailsContent extends StatelessWidget {
  final Admin admin;

  const AdminDetailsContent({required this.admin});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            admin.name[0].toUpperCase(),
            style: const TextStyle(fontSize: 32),
          ),
        ).center.pb6,
        AdminDetailItem(label: 'الاسم', value: admin.name),
        AdminDetailItem(label: 'البريد الإلكتروني', value: admin.email),
        AdminDetailItem(
          label: 'الحالة',
          value: admin.isActive ? 'نشط' : 'غير نشط',
        ),
        AdminDetailItem(
          label: 'تاريخ الإنشاء',
          value: admin.createdAt.toString().split(' ')[0],
        ),
      ],
    );
  }
}
