import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routes/app_routes_fun.dart';

class ToastHelperOne {
  static final ToastHelperOne _instance = ToastHelperOne._internal();
  factory ToastHelperOne() => _instance;
  ToastHelperOne._internal();

  void _showToast({
    required String msg,
    String? description,
    required Color backgroundColor,
    required Alignment alignment,
    required IconData icon,
  }) {
    final context = navigatorKey.currentContext!;
    final overlay = Overlay.of(context);
    final theme = Theme.of(context);

    final toast = OverlayEntry(
      builder: (_) => Positioned(
        top: alignment == Alignment.topCenter ? 50.h : null,
        bottom: alignment == Alignment.bottomCenter ? 50.h : null,
        left: 20.w,
        right: 20.w,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        if (description != null)
                          Text(description,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white70,
                              )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(toast);

    Future.delayed(Duration(seconds: 2), () {
      toast.remove();
    });
  }

  void success({required String msg, required String description}) {
    _showToast(
      msg: msg,
      description: description,
      backgroundColor: Colors.green,
      alignment: Alignment.topCenter,
      icon: Icons.check_circle,
    );
  }

  void error({required String msg, String? description}) {
    _showToast(
      msg: msg,
      description: description,
      backgroundColor: Colors.red,
      alignment: Alignment.topRight,
      icon: Icons.error,
    );
  }

  void warning({required String msg, required String description}) {
    _showToast(
      msg: msg,
      description: description,
      backgroundColor: Colors.orange,
      alignment: Alignment.topCenter,
      icon: Icons.warning,
    );
  }
}
