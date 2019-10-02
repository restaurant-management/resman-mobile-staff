import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String usernameOrEmail;

  LoggedIn(this.usernameOrEmail, this.token) : super([token]);

  @override
  String toString() => 'LoggedIn { user: $usernameOrEmail }';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  // TODO: implement props
  List<Object> get props => null;
}