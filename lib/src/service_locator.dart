import 'package:zef_di_abstractions/zef_di_abstractions.dart';

import 'concrete_service_locator.dart';

/// A central class for managing dependencies and providing service instances in a dependency injection framework.
///
/// This class allows for registering and resolving service instances based on types, names, keys, and environments.
/// It supports singleton and factory-based registrations to provide flexibility in managing service lifecycles.
abstract class ServiceLocator {
  static ServiceLocator? _instance;

  /// Gets the singleton instance of the [ServiceLocator].
  ///
  /// Throws [StateError] if the [ServiceLocator] has not been initialized using the [ServiceLocatorBuilder].
  static ServiceLocator get instance {
    if (_instance == null) {
      throw StateError(
          '$ServiceLocator must be initialized using the $ServiceLocatorBuilder before accessing the instance.');
    }
    return _instance!;
  }

  /// A convenience getter for accessing the singleton instance of the [ServiceLocator].
  static ServiceLocator get I => instance;

  /// Registers a singleton instance of a service with the locator.
  ///
  /// [instance] - The singleton instance to register.
  /// [interfaces] - Optional list of interfaces that the instance conforms to, used for interface-based resolution.
  /// [name] - An optional name to register the instance under; allows for named registrations.
  /// [key] - An optional key to further qualify the registration; useful for scenarios where type and name are insufficient.
  /// [environment] - An optional environment tag to restrict the registration's availability to certain runtime environments.
  void registerInstance<T extends Object>(
    T instance, {
    List<Type>? interfaces,
    String? name,
    dynamic key,
    String? environment,
  });

  /// Registers a factory method for instance creation with the locator.
  ///
  /// [factory] - A function that returns an instance of type [T], allowing for lazy instantiation.
  /// [interfaces] - Optional list of interfaces that the factory's products conform to, used for interface-based resolution.
  /// [name] - An optional name for the factory registration; allows for named factory registrations.
  /// [key] - An optional key to further qualify the registration; useful for complex registration scenarios.
  /// [environment] - An optional environment tag to restrict the factory registration's availability to certain runtime environments.
  void registerFactory<T extends Object>(
    T Function(ServiceLocator serviceLocator) factory, {
    List<Type>? interfaces,
    String? name,
    dynamic key,
    String? environment,
  });

  /// Retrieves the first registered instance of type [T] that matches the given criteria.
  ///
  /// [interface] - An optional interface type to filter the instances by the interface they implement.
  /// [name] - An optional name to filter the instances by their registered name.
  /// [key] - An optional key to further refine the filtering of instances.
  /// [environment] - An optional environment tag to filter instances available in the specified environment.
  /// Returns `null` if no matching instance is found.
  T? getFirst<T extends Object>({
    Type? interface,
    String? name,
    dynamic key,
    String? environment,
  });

  /// Retrieves all instances of type [T] matching the specified criteria.
  ///
  /// [interface] - An optional interface type to filter the instances by the interface they implement.
  /// [name] - An optional name to filter the instances by their registered name.
  /// [key] - An optional key to further refine the filtering of instances.
  /// [environment] - An optional environment tag to filter instances available in the specified environment.
  /// Returns an empty list if no matching instances are found.
  List<T> getAll<T extends Object>({
    Type? interface,
    String? name,
    dynamic key,
    String? environment,
  });

  /// Overrides an existing singleton registration with a new instance.
  ///
  /// [instance] - The new instance to replace the existing registration.
  /// [name] - An optional name to specify which named registration to override.
  /// [key] - An optional key to further specify which registration to override.
  /// [environment] - An optional environment tag to specify which environment-specific registration to override.
  void overrideInstance<T extends Object>(
    T instance, {
    String? name,
    dynamic key,
    String? environment,
  });

  /// Overrides an existing factory registration with a new factory method.
  ///
  /// [factory] - The new factory method to replace the existing factory registration.
  /// [name] - An optional name to specify which named factory registration to override.
  /// [key] - An optional key to further specify which factory registration to override.
  /// [environment] - An optional environment tag to specify which environment-specific factory registration to override.
  void overrideFactory<T extends Object>(
    T Function(ServiceLocator serviceLocator) factory, {
    String? name,
    dynamic key,
    String? environment,
  });

  /// Unregisters instances and factories of type [T] matching the specified criteria.
  ///
  /// [name] - An optional name to specify which named registrations to unregister.
  /// [key] - An optional key to further specify which registrations to unregister.
  /// [environment] - An optional environment tag to specify which environment-specific registrations to unregister.
  void unregister<T extends Object>({
    String? name,
    dynamic key,
    String? environment,
  });

  /// Clears all registrations from the service locator.
  ///
  /// This method removes all singleton and factory registrations, resetting the service locator to its initial state.
  void unregisterAll();
}

/// [ServiceLocatorBuilder] provides a fluent interface for configuring and initializing a [ServiceLocator].
///
/// This builder allows for the customization of the underlying adapter and configuration settings used by the [ServiceLocator].
/// It follows the builder pattern, enabling a chainable setup process before finalizing the creation of the [ServiceLocator] instance.
class ServiceLocatorBuilder {
  ServiceLocatorAdapter? _adapter;
  ServiceLocatorConfig? _config;

  /// Sets the adapter for the [ServiceLocator].
  ///
  /// The adapter is responsible for the actual mechanism of service registration and resolution within the [ServiceLocator].
  /// It defines how services are stored, retrieved, and managed at runtime.
  ///
  /// [adapter] - An instance of [ServiceLocatorAdapter] that provides the necessary implementation for service management.
  ///
  /// Returns the [ServiceLocatorBuilder] instance to allow for method chaining.
  ServiceLocatorBuilder withAdapter(ServiceLocatorAdapter adapter) {
    _adapter = adapter;
    return this;
  }

  /// Sets the configuration settings for the [ServiceLocator].
  ///
  /// The configuration settings control various aspects of the [ServiceLocator]'s behavior, such as logging and environment-specific settings.
  ///
  /// [config] - An instance of [ServiceLocatorConfig] that encapsulates the configuration settings for the [ServiceLocator].
  ///
  /// Returns the [ServiceLocatorBuilder] instance to allow for method chaining.
  ServiceLocatorBuilder withConfig(ServiceLocatorConfig config) {
    _config = config;
    return this;
  }

  /// Finalizes the configuration and creates the [ServiceLocator] instance.
  ///
  /// This method finalizes the setup of the [ServiceLocator] with the provided adapter and configuration settings.
  /// It must be called after all desired configurations have been set using the builder methods.
  ///
  /// Throws [StateError] if the [ServiceLocator] has already been initialized to ensure a single instance.
  /// Throws [StateError] if an adapter has not been set, as it is essential for the [ServiceLocator]'s operation.
  void build() {
    if (ServiceLocator._instance != null) {
      throw StateError('ServiceLocator has already been initialized and cannot be configured again.');
    }

    if (_adapter == null) {
      throw StateError('A ServiceLocatorAdapter must be provided before building the ServiceLocator.');
    }

    // Assigns the newly configured ServiceLocator instance to its singleton reference.
    ServiceLocator._instance = ConcreteServiceLocator(adapter: _adapter!, config: _config);
  }
}
