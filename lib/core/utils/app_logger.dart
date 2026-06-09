import 'package:logger/logger.dart';
import 'package:phicore/core/constants/env_config.dart';

/// Merkezi logger. Prod'da sadece error, dev'de her şey.
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      noBoxingByDefault: true,
    ),
    level: EnvConfig.enableLogging ? Level.debug : Level.error,
  );

  static void debug(String message, {String? tag}) {
    _logger.d(_format(tag, message));
  }

  static void info(String message, {String? tag}) {
    _logger.i(_format(tag, message));
  }

  static void warning(String message, {String? tag}) {
    _logger.w(_format(tag, message));
  }

  static void error(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _logger.e(_format(tag, message), error: error, stackTrace: stackTrace);
  }

  static String _format(String? tag, String message) =>
      tag != null ? '[$tag] $message' : message;
}
