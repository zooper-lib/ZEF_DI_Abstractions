class ServiceLocatorConfig {
  const ServiceLocatorConfig({
    this.throwErrors = false,
    this.allowMultipleInstances = true,
  });

  /// Indicates if the service locator should throw errors when they occur.
  /// If set to `false`, the service locator will log the error and continue.
  /// This does not prevent the framework from throwing errors when an internal error occurs.
  final bool throwErrors;

  /// Indicates if the service locator should allow multiple instances of the same type.
  /// If set to `false`, the service locator will throw an error when it detects multiple instances of the same type.
  final bool allowMultipleInstances;
}
