import 'package:flutter/material.dart';

import '../../../../../core/utils/ui_extensions/extensions_init.dart';

class AdminDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const AdminDetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).labelMedium(color: Colors.grey),
        Text(value).h6,
        const Divider(),
      ],
    ).pb4;
  }
}
