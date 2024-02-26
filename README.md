# zef_di_abstractions

A dart library which provides abstractions for dependency injection.

## Features

- **Framework Agnostic**: Designed to be a flexible wrapper, this package can be used with any Dependency Injection (DI) framework, offering a unified interface for service registration and resolution.
- **Multiple Service Resolution**: Supports resolving multiple services registered under the same interface, enhancing the flexibility of service retrieval in complex applications.
- **Custom Adapter Integration**: Enables users to integrate any external DI framework by writing custom adapters, ensuring compatibility and extending functionality according to project needs.

## Getting Started

To use this package, you'll first need to choose a DI framework and then implement an adapter to integrate it with the wrapper. There is already a library which provides a wrapper to use with this package: [zef_di_inglue](https://pub.dev/packages/zef_di_inglue).

## Implementing a Custom Adapter

Since this package does not provide direct implementations for DI frameworks, you'll need to create a custom adapter for your chosen framework. Here's a conceptual example to guide you:

```dart
class MyDIAdapter extends ServiceLocatorAdapter {
  // Implement the adapter methods using your chosen DI framework
}
```

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

### Instances

#### Simple registration

To register an instance you directly pass an instance of the object you want to have registered:

```dart
ServiceLocator.I.registerInstance(MyService());
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

#### Named registration

You can pass a name with your registration.

```dart
ServiceLocator.I.registerInstance(MyService(), name: 'One');
ServiceLocator.I.registerInstance(MyService(), name: 'Two');
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

### Factory registration

#### Simple registration

The difference here to the instance registration is, that you provide a function which tells the framework how to create the instance.

```dart
ServiceLocator.I.registerFactory<MyService>(
        (serviceLocator, namedArgs) => MyService(),
      );
```

And to resolve, you do the same as with the instance resolving:

```dart
final MyService myService = ServiceLocator.I.resolve<MyService>();
```

So every time we call `resolve()` on a as factory registered type we will create a new instance of this class.

---

**NOTE**

The difference to `registerInstance()` is, that with a factory you construct the object at runtime.

---

#### Resolving with parameters

One feature for factories is, that you can pass arguments to resolve the instance.
First you need to tell the framework how to resolve the factory:

```dart
ServiceLocator.I.registerFactory<UserService>(
        (ServiceLocator locator, Map<String, dynamic> namedArgs) => UserService(
          id: namedArgs['theUserId'] as UserId, // This is how your parameter will be provided
          username: namedArgs['theUsername'] as String, // This is how your parameter will be provided
          password: namedArgs['thePassword'] as String, // This is how your parameter will be provided
        ),
      );
```

As you can see the Function to register a factory has two parameters:

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

## Customization and Extensibility

Our package's design encourages customization and extensibility. By creating adapters for your chosen DI frameworks, you can leverage our wrapper's features while utilizing the specific functionalities and optimizations of those frameworks.

## Contributing

Contributions are welcome! Please read our contributing guidelines and code of conduct before submitting pull requests or issues. Also every annotation or idea to improve is warmly appreciated.
