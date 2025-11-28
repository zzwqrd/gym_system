import 'package:flutter/material.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String size;
  final String label;

  const LegendItem({
    super.key,
    required this.color,
    required this.size,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: color.circleDecoration),
        8.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            size.withStyle(fontSize: 12, fontWeight: FontWeight.bold),
            label.withStyle(fontSize: 10, color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
