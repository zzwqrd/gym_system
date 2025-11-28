import 'package:flutter/material.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: context.icon28)
            .paddingAll(15)
            .container(decoration: context.categoryDecoration(bgColor)),
        8.verticalSpace,
        label.labelMedium(),
      ],
    );
  }
}
