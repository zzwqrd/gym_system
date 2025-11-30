import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../database/database_constants.dart';
import '../../di/service_locator.dart';
import '../routes/app_routes_fun.dart';
import '../routes/routes.dart';
import 'app_logger.dart';
import '../resources/shared_pref_helper.dart';

/// A utility class that provides helper functions for common tasks
/// such as routing, transitions, and checking user states from local storage.
class AppHelperFunctions {
  // Singleton Instance of AppHelperFunctions
  static final AppHelperFunctions _instance = AppHelperFunctions._internal();

  // Factory constructor to provide the singleton instance
  factory AppHelperFunctions() => _instance;

  // Private constructor to initialize singleton instance
  AppHelperFunctions._internal();

  /// A set of helper functions to create custom page transitions in Flutter.

  /// Creates a slide transition from bottom to top for a given page.
  PageRouteBuilder<dynamic> slideFromBottomToTopTransition({
    required Widget page,
  }) {
    return PageRouteBuilder<dynamic>(
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => page,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const Offset begin = Offset(0, 1); // Slide in from bottom
            const Offset end = Offset.zero; // End at the original position
            const Cubic curve = Curves.easeOutQuint; // Easing curve
            final Animatable<Offset> tween = Tween<Offset>(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
    );
  }

  /// Creates a fade transition for a given page.
  PageRouteBuilder<dynamic> fadeTransition({required Widget page}) {
    return PageRouteBuilder<dynamic>(
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => page,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(opacity: animation, child: child);
          },
    );
  }

  /// Creates a slide transition from right to left for a given page.
  PageRouteBuilder<dynamic> slideFromRightTransition({required Widget page}) {
    return PageRouteBuilder<dynamic>(
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => page,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const Offset begin = Offset(1, 0); // Slide in from right
            const Offset end = Offset.zero; // End at the original position
            const Cubic curve = Curves.easeOutQuint; // Easing curve
            final Animatable<Offset> tween = Tween<Offset>(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
    );
  }

  /// Creates a slide transition from top to bottom for a given page.
  PageRouteBuilder<dynamic> slideFromTopToBottomTransition({
    required Widget page,
  }) {
    return PageRouteBuilder<dynamic>(
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => page,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const Offset begin = Offset(0, -1); // Slide in from top
            const Offset end = Offset.zero; // End at the original position
            const Cubic curve = Curves.easeOutQuint; // Easing curve
            final Animatable<Offset> tween = Tween<Offset>(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
    );
  }

  /// Checks cached keys in local storage to determine which screen to navigate to.
  Future<void> checkCachedKeysAndNavigate() async {
    try {
      final String? token = await SharedPrefHelper().getSecuredToken(
        DatabaseConstants.tokenKey,
      );
      final bool? hasDoneOnboarding = sl<SharedPreferences>().getBool(
        DatabaseConstants.onboardingKey,
      );
      AppLogger().info('User Token: $token');
      AppLogger().info('Has Completed Onboarding: $hasDoneOnboarding');

      if (hasDoneOnboarding != null && hasDoneOnboarding == true) {
        if (token != null && token.isNotEmpty) {
          await Navigator.of(
            navigatorKey.currentContext!,
          ).pushNamedAndRemoveUntil(
            RouteNames.mainLayout,
            (Route<dynamic> route) => false,
          );
        } else {
          await Navigator.of(
            navigatorKey.currentContext!,
          ).pushNamedAndRemoveUntil(
            RouteNames.login,
            (Route<dynamic> route) => false,
          );
        }
      } else {
        await Navigator.of(
          navigatorKey.currentContext!,
        ).pushNamedAndRemoveUntil(
          RouteNames.onboarding,
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      AppLogger().error('Error while checking cached keys: $e');
      await Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        RouteNames.onboarding,
        (Route<dynamic> route) => false,
      );
    }
  }

  String formatDate(DateTime dateTime) {
    final String formattedDate = DateFormat('d MMM y').format(dateTime);
    return formattedDate;
  }

  String formatDateTime(DateTime dateTime) {
    final time = dateTime.toLocal();
    final String formattedDate = DateFormat('d MMM y').format(time);
    final String formattedTime = DateFormat('hh:mm a').format(time);
    return '$formattedDate - $formattedTime';
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // Future<void> makePhoneCall(String phoneNumber) async {
  //   final Uri phoneUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );

  //   if (await canLaunchUrl(phoneUri)) {
  //     await launchUrl(phoneUri);
  //   } else {
  //     throw Exception('Could not launch phone call to $phoneNumber');
  //   }
  // }

  // Future<void> openMaps(double latitude, double longitude) async {
  //   final String googleMapsUrl =
  //       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  //   final Uri mapsUri = Uri.parse(googleMapsUrl);

  //   if (await canLaunchUrl(mapsUri)) {
  //     await launchUrl(mapsUri);
  //   } else {
  //     throw Exception(
  //       'Could not launch Google Maps for coordinates ($latitude, $longitude)',
  //     );
  //   }
  // }

  String? formatTime(num? time) {
    if (time == null) return null;

    // ignore: parameter_assignments
    if (time == 24) time = 0;

    final int hours = time.toInt() % 24; // Extract integer hours
    final int minutes = ((time - hours) * 60).round(); // Calculate minutes
    final String period = hours < 12 ? 'AM' : 'PM';
    final int formattedHour = hours == 0
        ? 12
        : (hours > 12 ? hours - 12 : hours);

    return '$formattedHour:${minutes.toString().padLeft(2, '0')} $period';
  }

  String formatHolidayDate(DateTime date) {
    return DateFormat('yyyy-M-d').format(date);
  }

  String formatDateToDayMonthYear(DateTime dateTime) {
    return '${dateTime.day} ${_monthName(dateTime.month)} ${dateTime.year}';
  }

  String formatDateToMonthYear(DateTime dateTime) {
    return '${_monthName(dateTime.month)} ${dateTime.year}';
  }

  String formatDateTimeWithTime(DateTime dateTime) {
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = _monthName(dateTime.month);
    final String year = dateTime.year.toString();
    final String hour = dateTime.hour > 12
        ? (dateTime.hour - 12).toString()
        : dateTime.hour.toString();
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = dateTime.hour < 12 ? 'AM' : 'PM';

    final String formattedDate = '$day $month $year - $hour:$minute$period';
    return formattedDate;
  }

  String _monthName(int month) {
    const List<String> months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
