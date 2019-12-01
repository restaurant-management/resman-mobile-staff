import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../respositories/responsitory.dart';
import '../authenticationBloc/bloc.dart';
import '../authenticationBloc/event.dart';
import 'event.dart';
import 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository _repository = Repository.instance;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc})
      : assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await _repository.authenticate(
            usernameOrEmail: event.usernameOrEmail,
//          usernameOrEmail: "2",
          password: event.password,
        );
        authenticationBloc.dispatch(LoggedIn(event.usernameOrEmail, token));
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }

    if (event is InitializeLoginForm) {
      yield LoginInitial();
    }
  }
}
