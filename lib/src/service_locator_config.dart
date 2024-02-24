class ServiceLocatorConfig {
  const ServiceLocatorConfig({
    this.throwErrors = false,
  });

  /// Indicates if the service locator should throw errors when they occur.
  /// If set to `false`, the service locator will log the error and continue
  final bool throwErrors;
}
