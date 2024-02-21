# zef_di_abstractions

Your Package Description: A brief description of what your package does and its primary use case.

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

### Registering Services

```dart
ServiceLocator.I.registerInstance(YourService());
ServiceLocator.I.registerFactory(() => YourService());
```

### Resolving Services

Regardless of the underlying DI framework, you can resolve services through our unified interface:

```dart
// For single service resolution
final myService = ServiceLocator.I.getFirst<MyServiceInterface>();

// For multiple services under the same interface
final myServices = ServiceLocator.I.getAll<MyServiceInterface>();
```

## Customization and Extensibility

Our package's design encourages customization and extensibility. By creating adapters for your chosen DI frameworks, you can leverage our wrapper's features while utilizing the specific functionalities and optimizations of those frameworks.

## Contributing

Contributions are welcome! Please read our contributing guidelines and code of conduct before submitting pull requests or issues. Also every annotation or idea to improve is warmly appreciated.
