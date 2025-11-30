import 'package:flutter/material.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../data/model/model.dart';

class AdminCard extends StatelessWidget {
  final Admin admin;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const AdminCard({
    super.key,
    required this.admin,
    required this.onEdit,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Text(admin.name[0].toUpperCase())),
        title: Text(admin.name).h6,
        subtitle: Text(admin.email).bodySmall(),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ).paddingAll(8),
    ).paddingSymmetric(horizontal: 16, vertical: 8);
  }
}
