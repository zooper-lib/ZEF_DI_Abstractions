import 'package:any_of/any_of.dart';

class AlreadyRegistered extends AnyOfType {
  final Type _type;
  final String? _name;
  final dynamic _key;
  final String? _environment;

  AlreadyRegistered(
    this._type, [
    this._name,
    this._key,
    this._environment,
  ]);

  Type get type => _type;
  String? get name => _name;
  dynamic get key => _key;
  String? get environment => _environment;
}
