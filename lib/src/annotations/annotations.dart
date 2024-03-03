abstract class BaseRegister {
  final String? _name;
  final dynamic _key;
  final String? _environment;

  const BaseRegister({String? name, dynamic key, String? environment})
      : _name = name,
        _key = key,
        _environment = environment;

  String? get name => _name;
  dynamic get key => _key;
  String? get environment => _environment;
}

class RegisterInstance extends BaseRegister {
  const RegisterInstance({super.name, super.key, super.environment});
}

class RegisterFactory extends BaseRegister {
  const RegisterFactory({super.name, super.key, super.environment});
}

class RegisterFactoryMethod {
  const RegisterFactoryMethod();
}
