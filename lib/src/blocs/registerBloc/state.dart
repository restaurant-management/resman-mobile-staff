import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super();
}

class RegisterInitial extends RegisterState {
  @override
  String toString() => 'RegisterInitial';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RegisterLoading extends RegisterState {
  @override
  String toString() => 'RegisterLoading';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RegisterSuccess extends RegisterState {
  @override
  String toString() => 'RegisterSuccess';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);

  @override
  String toString() => 'RegisterFailure';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
