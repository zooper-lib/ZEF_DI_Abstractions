abstract class Registration {
  final String? _name;
  final dynamic _key;
  final String? _environment;

  const Registration({String? name, dynamic key, String? environment})
      : _name = name,
        _key = key,
        _environment = environment;

  String? get name => _name;
  dynamic get key => _key;
  String? get environment => _environment;
}

class RegisterInstance extends Registration {
  const RegisterInstance({super.name, super.key, super.environment});
}

class RegisterFactory extends Registration {
  const RegisterFactory({super.name, super.key, super.environment});
}

class RegisterFactoryMethod {
  const RegisterFactoryMethod();
}
