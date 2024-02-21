import 'dart:developer' as developer;

import 'package:zef_di_abstractions/zef_di_abstractions.dart';

class LogHelper {
  static void log(
    String message, {
    int level = LogLevel.debug,
    int minimumLogLevel = LogLevel.warning,
  }) {
    if (level == LogLevel.debug && minimumLogLevel <= LogLevel.debug) {
      logDebug(message);
    } else if (level == LogLevel.info && minimumLogLevel <= LogLevel.info) {
      logInfo(message);
    } else if (level == LogLevel.warning && minimumLogLevel <= LogLevel.warning) {
      logWarning(message);
    } else if (level == LogLevel.error && minimumLogLevel <= LogLevel.error) {
      logError(message);
    } else if (level == LogLevel.critical && minimumLogLevel <= LogLevel.critical) {
      logCritical(message);
    }
  }

  static void logDebug(String message, {String name = 'dependency_injection'}) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '🐛 [DEBUG] [$timestamp] $message';
    developer.log(logMessage, name: name, level: LogLevel.debug);
  }

  static void logInfo(String message, {String name = 'dependency_injection'}) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = 'ℹ️ [INFO] [$timestamp] $message';
    developer.log(logMessage, name: name, level: LogLevel.info);
  }

  static void logWarning(String message, {String name = 'dependency_injection'}) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '❗ [WARNING] [$timestamp] $message';
    developer.log(logMessage, name: name, level: LogLevel.warning);
  }

  static void logError(String message, {String name = 'dependency_injection'}) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '🛑 [ERROR] [$timestamp] $message';
    developer.log(logMessage, name: name, level: LogLevel.error);
  }

  static void logCritical(String message, {String name = 'dependency_injection'}) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '🔥 [CRITICAL] [$timestamp] $message';
    developer.log(logMessage, name: name, level: LogLevel.critical);
  }
}
