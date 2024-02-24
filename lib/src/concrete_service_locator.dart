import 'package:zef_log_core/zef_log_core.dart';

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
      if (_config.throwErrors) {
        throw StateError(registrationAlreadyExistsForType(T));
      } else {
        Logger.I.warning(message: registrationAlreadyExistsForType(T));
        return;
      }
    }

    // On internal error
    if (response.isThird) {
      if (_config.throwErrors) {
        throw StateError(internalErrorOccurred(response.third.message));
      } else {
        Logger.I.fatal(
          message: internalErrorOccurred(response.third.message),
          error: response.third.message,
          stackTrace: StackTrace.current,
        );
        return;
      }
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
    if (response.isSecond) {
      if (_config.throwErrors) {
        throw StateError(registrationAlreadyExistsForType(T));
      } else {
        Logger.I.warning(message: registrationAlreadyExistsForType(T));
        return;
      }
    }

    // On internal error
    if (response.isThird) {
      if (_config.throwErrors) {
        throw StateError(internalErrorOccurred(response.third.message));
      } else {
        Logger.I.fatal(
          message: internalErrorOccurred(response.third.message),
          error: response.third.message,
          stackTrace: StackTrace.current,
        );
        return;
      }
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
    if (response.isSecond) {
      if (_config.throwErrors) {
        throw StateError(noRegistrationFoundForType(T));
      } else {
        Logger.I.warning(message: noRegistrationFoundForType(T));
        return null;
      }
    }

    // On internal error
    if (response.isThird) {
      if (_config.throwErrors) {
        throw StateError(internalErrorOccurred(response.third.message));
      } else {
        Logger.I.fatal(
          message: internalErrorOccurred(response.third.message),
          error: response.third.message,
          stackTrace: StackTrace.current,
        );
        return null;
      }
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
      if (_config.throwErrors) {
        throw StateError(noRegistrationFoundForType(T));
      } else {
        Logger.I.warning(message: noRegistrationFoundForType(T));
        return [];
      }
    }

    // On internal error
    if (response.isThird) {
      if (_config.throwErrors) {
        throw StateError(internalErrorOccurred(response.third.message));
      } else {
        Logger.I.fatal(
          message: internalErrorOccurred(response.third.message),
          error: response.third.message,
          stackTrace: StackTrace.current,
        );
        return [];
      }
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
      if (_config.throwErrors) {
        throw StateError(response.second.message);
      } else {
        Logger.I.fatal(
          message: internalErrorOccurred(response.second.message),
          error: response.second.message,
          stackTrace: StackTrace.current,
        );
        return;
      }
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
      if (_config.throwErrors) {
        throw StateError(response.second.message);
      } else {
        Logger.I.fatal(
          message: internalErrorOccurred(response.second.message),
          error: response.second.message,
          stackTrace: StackTrace.current,
        );
        return;
      }
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
    if (response.isSecond) {
      if (_config.throwErrors) {
        throw StateError(noRegistrationFoundForType(T));
      } else {
        Logger.I.warning(message: noRegistrationFoundForType(T));
        return;
      }
    }

    // On internal error
    if (response.isThird) {
      if (_config.throwErrors) {
        throw StateError(response.third.message);
      } else {
        Logger.I.fatal(
          message: internalErrorOccurred(response.third.message),
          error: response.third.message,
          stackTrace: StackTrace.current,
        );
        return;
      }
    }
  }

  @override
  void unregisterAll() {
    final response = _adapter.unregisterAll();

    // On internal error
    if (response.isSecond) {
      if (_config.throwErrors) {
        throw StateError(response.second.message);
      } else {
        Logger.I.fatal(
          message: internalErrorOccurred(response.second.message),
          error: response.second.message,
          stackTrace: StackTrace.current,
        );
        return;
      }
    }
  }
}
