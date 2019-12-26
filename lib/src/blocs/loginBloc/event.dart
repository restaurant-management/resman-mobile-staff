import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class LoginButtonPressed extends LoginEvent {
  final String usernameOrEmail;
  final String password;

  LoginButtonPressed({@required this.usernameOrEmail, @required this.password})
      : super([usernameOrEmail, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $usernameOrEmail, password: $password }';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class InitializeLoginForm extends LoginEvent {
  @override
  String toString() => 'InitializeLoginForm';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
