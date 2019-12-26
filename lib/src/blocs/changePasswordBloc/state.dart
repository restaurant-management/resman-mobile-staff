import 'package:equatable/equatable.dart';

abstract class ChangePasswordBlocState extends Equatable {
  ChangePasswordBlocState([List props = const []]) : super();
}

class ChangePasswordBlocInitialize extends ChangePasswordBlocState {
  @override
  String toString() => 'ChangePasswordBlocInitialize';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ChangePasswordBlocChanging extends ChangePasswordBlocState {
  @override
  String toString() => 'ChangePasswordBlocChanging';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ChangePasswordBlocChanged extends ChangePasswordBlocState {
  @override
  String toString() => 'ChangePasswordBlocChanged';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ChangePasswordBlocFailure extends ChangePasswordBlocState {
  final String error;

  ChangePasswordBlocFailure(this.error) : super([error]);

  @override
  String toString() => 'ChangePasswordBlocFailure ($error)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
