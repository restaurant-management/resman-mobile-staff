import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/currentUserBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/currentUserBloc/event.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';

import 'event.dart';
import 'state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Repository _repository = Repository.instance;
  final CurrentUserBloc _currentUserBloc = CurrentUserBloc();

  AuthenticationBloc._internal();

  static AuthenticationBloc _singleton = AuthenticationBloc._internal();

  factory AuthenticationBloc() {
    return _singleton;
  }

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await _repository.hasToken();
      if (hasToken) {
        _currentUserBloc.add(FetchCurrentUserProfile());
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await _repository.persistToken(event.token, event.usernameOrEmail);
      _currentUserBloc.add(FetchCurrentUserProfile());
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await _repository.deleteToken();
      _currentUserBloc.add(LogOut());
      yield AuthenticationUnauthenticated();
    }
  }
}
