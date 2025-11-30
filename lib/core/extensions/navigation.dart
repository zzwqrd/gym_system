import 'package:flutter/material.dart';

extension NavigationExtension on RouteSettings {
  Map<String, dynamic> get args {
    if (arguments == null) {
      return {};
    }
    return arguments as Map<String, dynamic>;
  }
}
