import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/routes/app_routes_fun.dart';
import '../core/ui/ui_extensions/complete_flutter_extensions.dart'
    show AppTextStyles;

class MyTextApp extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final TextAlign? align;
  final bool copyable;
  final VoidCallback? onTap;
  final IconData? icon;
  final ImageProvider? image;
  final Color? iconColor;
  final double? iconSize;
  final double? imageSize;

  const MyTextApp({
    super.key,
    required this.title,
    this.style,
    this.align,
    this.copyable = false,
    this.onTap,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
  });

  factory MyTextApp.h1(
    String text, {
    TextAlign? align,
    bool copyable = false,
    VoidCallback? onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
  }) {
    return MyTextApp(
      title: text,
      style: navigatorKey.currentContext!.displayLarge,
      align: align,
      copyable: copyable,
      onTap: onTap,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
    );
  }

  factory MyTextApp.h2(
    String text, {
    TextAlign? align,
    bool copyable = false,
    VoidCallback? onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
  }) {
    return MyTextApp(
      title: text,
      style: navigatorKey.currentContext!.displayMedium,
      align: align,
      copyable: copyable,
      onTap: onTap,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
    );
  }

  factory MyTextApp.h3(
    String text, {
    TextAlign? align,
    bool copyable = false,
    VoidCallback? onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
  }) {
    return MyTextApp(
      title: text,
      style: navigatorKey.currentContext!.displaySmall,
      align: align,
      copyable: copyable,
      onTap: onTap,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
    );
  }

  factory MyTextApp.h4(
    String text, {
    TextAlign? align,
    bool copyable = false,
    VoidCallback? onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
  }) {
    return MyTextApp(
      title: text,
      style: navigatorKey.currentContext!.headlineLarge,
      align: align,
      copyable: copyable,
      onTap: onTap,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
    );
  }

  factory MyTextApp.h5(
    String text, {
    TextAlign? align,
    bool copyable = false,
    VoidCallback? onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    Color? color,
  }) {
    return MyTextApp(
      title: text,
      style: navigatorKey.currentContext!.headlineMedium,
      align: align,
      copyable: copyable,
      onTap: onTap,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
    );
  }

  factory MyTextApp.h6(
    String text, {
    TextAlign? align,
    bool copyable = false,
    VoidCallback? onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
  }) {
    return MyTextApp(
      title: text,
      style: navigatorKey.currentContext!.headlineSmall,
      align: align,
      copyable: copyable,
      onTap: onTap,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
    );
  }

  factory MyTextApp.nav(
    String text, {
    TextAlign? align,
    bool copyable = false,
    required VoidCallback onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
  }) {
    return MyTextApp(
      title: text,
      style: navigatorKey.currentContext!.bodyLarge.copyWith(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
      align: align,
      copyable: copyable,
      onTap: onTap,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
    );
  }

  factory MyTextApp.copyable(
    String text, {
    TextStyle? style,
    TextAlign? align,
    VoidCallback? onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
  }) {
    return MyTextApp(
      title: text,
      style: style ?? navigatorKey.currentContext!.bodyMedium,
      align: align,
      copyable: true,
      onTap: onTap,
      icon: icon,
      image: image,
      iconColor: iconColor,
      iconSize: iconSize,
      imageSize: imageSize,
    );
  }

  MyTextApp copyWith({
    String? title,
    TextStyle? style,
    TextAlign? align,
    bool? copyable,
    VoidCallback? onTap,
    IconData? icon,
    ImageProvider? image,
    Color? iconColor,
    double? iconSize,
    double? imageSize,
    double? fontSize,
  }) {
    return MyTextApp(
      title: title ?? this.title,
      style: style ?? this.style,
      align: align ?? this.align,
      copyable: copyable ?? this.copyable,
      onTap: onTap ?? this.onTap,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      imageSize: imageSize ?? this.imageSize,
    );
  }

  void _copyText(BuildContext context) {
    Clipboard.setData(ClipboardData(text: title));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('تم نسخ النص')));
  }

  @override
  Widget build(BuildContext context) {
    Widget textWidget;
    if (copyable) {
      textWidget = SelectableText(
        title,
        style: style,
        textAlign: align,
        onSelectionChanged: (selection, cause) {
          if (cause == SelectionChangedCause.longPress) {
            _copyText(context);
          }
        },
      );
    } else {
      textWidget = Text(title, style: style, textAlign: align);
    }

    List<Widget> rowChildren = [];
    if (icon != null) {
      rowChildren.add(
        Icon(
          icon,
          color: iconColor ?? Colors.black,
          size: iconSize ?? (style?.fontSize ?? 16),
        ),
      );
    }
    if (image != null) {
      rowChildren.add(
        Image(image: image!, width: imageSize ?? 24, height: imageSize ?? 24),
      );
    }
    if (icon != null || image != null) {
      rowChildren.add(const SizedBox(width: 8));
    }
    rowChildren.add(textWidget);

    Widget row = Row(mainAxisSize: MainAxisSize.min, children: rowChildren);

    if (onTap != null) {
      row = InkWell(onTap: onTap, child: row);
    }

    return row;
  }
}
