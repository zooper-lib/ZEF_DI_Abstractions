import 'package:zef_di_abstractions/zef_di_abstractions.dart';
import 'package:any_of/any_of.dart';

abstract class ServiceLocatorAdapter {
  /// Registers an instance of type [T].
  Triplet<Success, Conflict, InternalError> registerInstance<T extends Object>(
    T instance, {
    required List<Type>? interfaces,
    required String? name,
    required dynamic key,
    required String? environment,
    required bool allowMultipleInstances,
  });

  /// Registers a factory for type [T].
  Triplet<Success, Conflict, InternalError> registerFactory<T extends Object>(
    T Function(
      ServiceLocator serviceLocator,
      Map<String, dynamic> namedArgs,
    ) factory, {
    required List<Type>? interfaces,
    required String? name,
    required dynamic key,
    required String? environment,
    required bool allowMultipleInstances,
  });

  /// Retrieves an instance of type [T].
  Triplet<T, NotFound, InternalError> resolve<T extends Object>({
    required String? name,
    required dynamic key,
    required String? environment,
    required Map<String, dynamic> namedArgs,
    required bool resolveFirst,
  });

  /// Retrieves a List of instances of type [T].
  Triplet<List<T>, NotFound, InternalError> resolveAll<T extends Object>({
    required String? name,
    required dynamic key,
    required String? environment,
    required Map<String, dynamic> namedArgs,
  });

  /// Overrides an existing registration with a new instance of type [T].
  Doublet<Success, InternalError> overrideInstance<T extends Object>(
    T instance, {
    required String? name,
    required dynamic key,
    required String? environment,
  });

  /// Overrides an existing registration with a new factory of type [T].
  Doublet<Success, InternalError> overrideFactory<T extends Object>(
    T Function(
      ServiceLocator serviceLocator,
      Map<String, dynamic> namedArgs,
    ) factory, {
    required String? name,
    required dynamic key,
    required String? environment,
  });

  /// Unregisters an instance of type [T].
  Triplet<Success, NotFound, InternalError> unregister<T extends Object>({
    required String? name,
    required dynamic key,
    required String? environment,
  });

  /// Clears all registered instances.
  Doublet<Success, InternalError> unregisterAll();
}
