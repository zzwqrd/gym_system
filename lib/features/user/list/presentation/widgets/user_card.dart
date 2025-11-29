import 'package:flutter/material.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../data/model/model.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserCard({
    super.key,
    required this.user,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : ''),
        ),
        title: user.name.h6,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            user.email.bodySmall(),
            if (user.phone.isNotEmpty) user.phone.bodySmall(),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ).paddingAll(8),
    ).paddingSymmetric(horizontal: 16, vertical: 8);
  }
}
