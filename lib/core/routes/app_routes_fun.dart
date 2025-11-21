import 'package:flutter/material.dart';

Future<dynamic> push(String named, {dynamic arg}) {
  return Navigator.of(
    navigatorKey.currentContext!,
  ).pushNamed(named, arguments: arg);
}

Future<dynamic> replacement(String named, {dynamic arg}) {
  return Navigator.of(
    navigatorKey.currentContext!,
  ).pushReplacementNamed(named, arguments: arg);
}

Future<dynamic> pushAndRemoveUntil(String named, {dynamic arg}) {
  return Navigator.of(
    navigatorKey.currentContext!,
  ).pushNamedAndRemoveUntil(named, (route) => false, arguments: arg);
}

void pushBack([dynamic arg]) {
  return Navigator.of(navigatorKey.currentContext!).pop(arg);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();
