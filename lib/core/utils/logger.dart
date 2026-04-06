import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    level: kReleaseMode ? Level.off : Level.trace,
    printer: PrettyPrinter(
      noBoxingByDefault: true,
      methodCount: 0, // No method calls displayed
      errorMethodCount: 0, // No stack trace for errors
      colors: true, // Use colorful output
      printEmojis: true, // Display emojis
    ),
  );

  /// Log an info message
  static void info(String message) {
    _logger.i(message);
  }

  /// Log a debug message
  static void debug(String message) {
    _logger.d(message);
  }

  /// Log a warning message
  static void warning(String message) {
    _logger.w(message);
  }

  /// Log an error message
  static void error(
      String message, [
        Exception? error,
        StackTrace? stackTrace,
      ]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a trace message for detailed info
  static void trace(String message) {
    _logger.t(message);
  }

  /// Enable or disable logging globally
  static void setLoggingEnabled(bool isEnabled) {
    Logger.level = isEnabled ? Level.trace : Level.off;
  }
}