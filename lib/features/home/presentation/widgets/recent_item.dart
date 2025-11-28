import 'package:flutter/material.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';

class RecentItem extends StatelessWidget {
  final String name;
  final String size;
  final IconData icon;
  final Color iconColor;

  const RecentItem({
    super.key,
    required this.name,
    required this.size,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Icon(icon, color: iconColor)
                .paddingAll(10)
                .container(
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            15.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                name.withStyle(fontWeight: FontWeight.bold, fontSize: 14),
                4.verticalSpace,
                size.withStyle(color: Colors.grey, fontSize: 12),
              ],
            ).expanded(),
            const Icon(Icons.more_vert, color: Colors.grey),
          ],
        )
        .paddingAll(15)
        .container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade100),
          ),
        );
  }
}
