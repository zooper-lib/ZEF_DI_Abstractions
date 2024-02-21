import 'package:any_of/any_of.dart';

class RegistrationFailed extends AnyOfType {
  final Type _type;

  RegistrationFailed(this._type);

  Type get type => _type;
}
