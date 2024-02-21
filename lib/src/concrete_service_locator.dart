import 'helpers/log_helper.dart';
import 'helpers/user_messages.dart';
import 'service_locator.dart';
import 'service_locator_adapter.dart';
import 'service_locator_config.dart';

class ConcreteServiceLocator implements ServiceLocator {
  final ServiceLocatorAdapter _adapter;
  final ServiceLocatorConfig _config;

  ConcreteServiceLocator({
    required ServiceLocatorAdapter adapter,
    ServiceLocatorConfig? config,
  })  : _adapter = adapter,
        _config = config ?? const ServiceLocatorConfig();

  @override
  void registerInstance<T extends Object>(
    T instance, {
    List<Type>? interfaces,
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.registerInstance<T>(
      instance,
      interfaces: interfaces,
      name: name,
      key: key,
      environment: environment,
    );

    // On conflict
    if (response.isSecond) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }
  }

  @override
  void registerFactory<T extends Object>(
    T Function(ServiceLocator serviceLocator) factory, {
    List<Type>? interfaces,
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.registerFactory<T>(
      factory,
      interfaces: interfaces,
      name: name,
      key: key,
      environment: environment,
    );

    // On conflict
    if (response.isSecond && _config.minimumLogLevel <= LogLevel.warning) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }
  }

  @override
  T? getFirst<T extends Object>({
    Type? interface,
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.getFirst<T>(
      name: name,
      key: key,
      environment: environment,
    );

    // On not found
    if (response.isSecond && _config.minimumLogLevel <= LogLevel.warning) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );

      return null;
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }

    return response.first;
  }

  @override
  List<T> getAll<T extends Object>({
    Type? interface,
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.getAll<T>(
      name: name,
      key: key,
      environment: environment,
    );

    // On not found
    if (response.isSecond) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );
      return [];
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }

    return response.first;
  }

  @override
  void overrideInstance<T extends Object>(
    T instance, {
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.overrideInstance<T>(
      instance,
      name: name,
      key: key,
      environment: environment,
    );

    // On internal error
    if (response.isSecond) {
      LogHelper.log(
        internalErrorOccurred(response.second.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.second.message);
    }
  }

  @override
  void overrideFactory<T extends Object>(
    T Function(ServiceLocator serviceLocator) factory, {
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.overrideFactory<T>(
      factory,
      name: name,
      key: key,
      environment: environment,
    );

    // On internal error
    if (response.isSecond) {
      LogHelper.log(
        internalErrorOccurred(response.second.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.second.message);
    }
  }

  @override
  void unregister<T extends Object>({
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.unregister<T>(
      name: name,
      key: key,
      environment: environment,
    );

    // On not found
    if (response.isSecond && _config.minimumLogLevel <= LogLevel.warning) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }
  }

  @override
  void unregisterAll() {
    final response = _adapter.unregisterAll();

    // On internal error
    if (response.isSecond) {
      LogHelper.log(
        internalErrorOccurred(response.second.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.second.message);
    }
  }
}
