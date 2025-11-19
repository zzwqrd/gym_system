import 'package:flutter/material.dart';

class Unfocus extends StatefulWidget {
  final Widget? child;
  const Unfocus({super.key, this.child});

  @override
  State<Unfocus> createState() => _UnfocusState();
}

class _UnfocusState extends State<Unfocus> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector يستخدم للكشف عن اللمسات على الشاشة
      // ويقوم بإلغاء التركيز عند النقر على أي مكان في الشاشة
      // HitTestBehavior.opaque يعني أن اللمسة ستؤثر على كل المساحة
      // حتى لو لم يكن هناك عنصر مرئي في ذلك المكان
      // هذا يضمن أن أي نقر على الشاشة سيؤدي إلى إلغاء التركيز
      // FocusManager.instance.primaryFocus?.unfocus() يقوم بإلغاء التركيز
      // من العنصر الحالي الذي لديه التركيز، مما يسمح بإخفاء لوحة المفاتيوحات
      // أو أي عنصر آخر لديه التركيز حاليًا.
      // هذا مفيد في التطبيقات التي تحتوي على حقول إدخال نصية
      // حيث قد يرغب المستخدم في إلغاء التركيز عند النقر في أي مكان آخر
      // في الشاشة، مثل إخفاء لوحة المفاتيح عند النقر خارج حقل الإدخال.

      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: widget.child,
    );
  }
}
