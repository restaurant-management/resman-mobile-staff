import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super();
}

class RegisterButtonPressed extends RegisterEvent {
  final String username;
  final String email;
  final String password;

  RegisterButtonPressed(
      {@required this.username, @required this.email, @required this.password})
      : super([username, email, password]);

  @override
  String toString() => 'RegisterButtonPressed';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class InitializeRegisterForm extends RegisterEvent{
  @override
  String toString() => 'InitializeRegisterForm';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
