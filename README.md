# zef_di_abstractions

A dart library which provides abstractions for dependency injection.

> [!CAUTION]
> This project is discontinued, as it got renamed. Check out the new package [zef_di_core](https://pub.dev/packages/zef_di_core) instead.

## Features

- **Framework Agnostic**: Designed to be a flexible wrapper, this package can be used with any Dependency Injection (DI) framework, offering a unified interface for service registration and resolution.
- **Multiple Service Resolution**: Supports resolving multiple services registered under the same interface, enhancing the flexibility of service retrieval in complex applications.
- **Custom Adapter Integration**: Enables users to integrate any external DI framework by writing custom adapters, ensuring compatibility and extending functionality according to project needs.
- **Code generation**: Automatic dependency registration and resolution.

## Getting Started

To use this package, you'll first need to choose a DI framework and then implement an adapter to integrate it with the wrapper. There is already a library which provides a wrapper to use with this package: [zef_di_inglue](https://pub.dev/packages/zef_di_inglue).

## Implementing a Custom Adapter

Since this package does not provide direct implementations for DI frameworks, you'll need to create a custom adapter for your chosen framework. Here's a conceptual example to guide you:

```dart
class MyDIAdapter extends ServiceLocatorAdapter {
  // Implement the adapter methods using your chosen DI framework
}
```

## Definitions

- **Singleton**: You will register an instance of a type which is then stored in memory. This instance is then reused.
- **Transient**: You will register a factory which will be called every time you resolve the type. This way you will always get a new instance.
- **Lazy**: You will register a factory which will be called the first time you resolve the type and then the instance will be stored in memory. This way you will always get the same instance.

## Initialization and Usage

With your custom adapter in place, initialize the ServiceLocator like so:

```dart
void main() {
  ServiceLocatorBuilder()
    .withAdapter(MyDIAdapter())
    .build();

  // Your application logic here
}
```

### Singletons

#### Simple registration

To register a `Singleton` you directly pass an instance of the object you want to have registered:

```dart
ServiceLocator.I.registerSingleton(MyService());
```

And to resolve that instance you call the `resolve()` method:

```dart
final MyService myService = ServiceLocator.I.resolve<MyService>();
```

---

**NOTE**

You can register the same instance multiple times if you have set this in `ServiceLocatorConfig`. This is turned on by default.
The method `resolve()` will then return the first registered instance by default, but you can also get the last registered with:

```dart
final MyService myService = ServiceLocator.I.resolve<MyService>(resolveFirst: false);
```

The same principle applies to the following registration option

---

#### Registering with a factory

You can also register a `Singleton` with a factory:

```dart
ServiceLocator.I.registerSingletonFactory<MyService>(
  (serviceLocator, namedArgs) => MyService(),
);
```

This way you have more control over the instance creation.
Note that the factory will only be called once, and directly after the registration.

#### Named registration

You can pass a name with your registration.

```dart
ServiceLocator.I.registerSingleton(MyService(), name: 'One');
ServiceLocator.I.registerSingleton(MyService(), name: 'Two');
```

This way you can resolve different instances with ease:

```dart
final MyService myService = ServiceLocator.I.resolve<MyService>(name: 'one'); // Will return the instance with name `one`
final MyService myService = ServiceLocator.I.resolve<MyService>(name: 'two'); // Will return the instance with name `two`
```

#### Keyed registration

The same principle as named registrations, but with a different property

#### Environmental registration

The same principle as named registrations, but with a different property. Mostly used to define your instances under different environments like "dev", "test", "prod", ...

### Transient registration

#### Simple registration

```dart
ServiceLocator.I.registerTransient<MyService>(
        (serviceLocator, namedArgs) => MyService(),
      );
```

And to resolve, you do the same as with the `Singleton` resolution:

```dart
final MyService myService = ServiceLocator.I.resolve<MyService>();
```

So every time we call `resolve()` on a as `Transient` registered type we will create a new instance of this class.

---

**NOTE**

The difference to `registerSingleton()` is, that with a `Transient` you construct the object at runtime.

---

#### Resolving with parameters

One feature for `Transient` factories is, that you can pass arguments to resolve the instance.
First you need to tell the framework how to resolve the factory:

```dart
ServiceLocator.I.registerTransient<UserService>(
  (ServiceLocator locator, Map<String, dynamic> namedArgs) => UserService(
    id: namedArgs['theUserId'] as UserId, // This is how your parameter will be provided
    username: namedArgs['theUsername'] as String, // This is how your parameter will be provided
    password: namedArgs['thePassword'] as String, // This is how your parameter will be provided
  ),
);
```

As you can see the function to register a factory has two parameters:

- ServiceLocator locator
- Map<String, dynamic> namedArgs

The locator is just an instance of the `ServiceLocator`. As this is a singleton, you definitly can discard it and directly use `ServiceLocator.I.` if you want to pass an object which is already registered within the DI system.
The namedArgs is a Map of arguments you will pass when trying to resolve a factory:

```dart
final UserService userService =
  ServiceLocator.I.resolve<UserService>(
    namedArgs: {
      'theUserId': UserId('1'),
      'theUsername': 'HansZimmer123',
      'thePassword': 'blafoo1!',
    },
  );
```

If you don't pass a required named argument, a `TypeError` will be thrown.

### Lazy Registration

In addition to the existing `Singleton` and `Transient` registration capabilities, this package now supports `Lazy` registration of services. `Lazy` registration allows you to defer the creation of an object until it is first needed, which can improve the startup time of your application and reduce initial memory usage.

```dart
ServiceLocator.I.registerLazy<MyLazyService>(
  Lazy<MyLazyService>(() => MyLazyService()),
);
```

To resolve a `Lazy` registered service, you use the same resolve method:

```dart
final MyLazyService myLazyService = ServiceLocator.I.resolve<MyLazyService>();
```

The first call to resolve for a lazy registered service will instantiate the service, and subsequent calls will return the same instance, preserving the singleton nature of the service within the scope of the application.

#### Advantages of Lazy Registration

- **Improved Startup Performance**: By deferring the instantiation of services until they are actually needed, you can reduce the workload during application startup, leading to faster launch times.
- **Optimized Resource Usage**: Lazy registration helps in minimizing the memory footprint at startup by only creating service instances when they are required.
- **Flexibility**: This feature adds an extra layer of flexibility in managing service lifecycles, allowing for a more dynamic and responsive application structure.

## Code generation

If you want to use the code generator, please refer to [this package here](https://pub.dev/zef_di_abstractions_generator).

## Customization and Extensibility

Our package's design encourages customization and extensibility. By creating adapters for your chosen DI frameworks, you can leverage our wrapper's features while utilizing the specific functionalities and optimizations of those frameworks.

## Contributing

Contributions are welcome! Please read our contributing guidelines and code of conduct before submitting pull requests or issues. Also every annotation or idea to improve is warmly appreciated.
