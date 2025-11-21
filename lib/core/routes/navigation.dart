import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> push(String routeName, {Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    required RoutePredicate predicate,
    Object? arguments,
  }) => Navigator.pushNamedAndRemoveUntil(
    this,
    routeName,
    predicate,
    arguments: arguments,
  );

  void pop<T>([T? result]) => Navigator.of(this).pop<T>(result);

  bool canPop() => Navigator.of(this).canPop();
}
