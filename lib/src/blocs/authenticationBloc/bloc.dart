import 'dart:async';

import 'package:bloc/bloc.dart';

//import '../../repositories/repository.dart';
//import '../currentUserBloc/bloc.dart';
//import '../currentUserBloc/event.dart';
import 'event.dart';
import 'state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
//  final Repository _repository = Repository.instance;
//  final CurrentUserBloc _currentUserBloc = CurrentUserBloc();

  AuthenticationBloc._internal();

  static AuthenticationBloc _singleton = AuthenticationBloc._internal();

  factory AuthenticationBloc(){
    return _singleton;
  }

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = true;
      if (hasToken) {
//        _currentUserBloc.dispatch(FetchCurrentUserProfile());
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
//      await _repository.persistToken(event.token, event.usernameOrEmail);
//      _currentUserBloc.dispatch(FetchCurrentUserProfile());
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
//      await _repository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
