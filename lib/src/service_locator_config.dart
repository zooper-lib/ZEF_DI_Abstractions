class ServiceLocatorConfig {
  const ServiceLocatorConfig({
    this.minimumLogLevel = LogLevel.debug,
  });

  /// The minimum log level that should be logged.
  final int minimumLogLevel;
}

/// The LogLevel class is a helper class to define the different log levels.
///
/// The log levels are used to determine the severity of a log message.
/// The numbers are the same as in the package `logging` and the `dart:developer` package.
class LogLevel {
  static const int debug = 100;
  static const int info = 200;
  static const int warning = 400;
  static const int error = 500;
  static const int critical = 600;
}
