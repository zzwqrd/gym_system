import 'loger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  final LoggerDebug _logger = LoggerDebug(headColor: "AppLog");

  void info(String message) {
    _logger.blue(message, "INFO");
  }

  void error(String message) {
    _logger.red(message, "ERROR");
  }
}
