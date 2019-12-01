import 'package:bloc/bloc.dart';
import 'package:resman_mobile_staff/src/models/roleModel.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';

import 'event.dart';
import 'state.dart';

/// Singleton Bloc
class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final Repository _repository = Repository();

  List<RoleModel> _roles;
  List<RoleModel> get getRoles => _roles;

  CurrentUserBloc._internal();

  static CurrentUserBloc _singleton = CurrentUserBloc._internal();

  factory CurrentUserBloc() {
    return _singleton;
  }

  @override
  CurrentUserState get initialState => CurrentUserProfileEmpty();

  @override
  Stream<CurrentUserState> mapEventToState(CurrentUserEvent event) async* {
    if (event is FetchCurrentUserProfile) {
      yield CurrentUserProfileFetching();
      try {
        await _repository.fetchCurrentUserProfile();
        yield CurrentUserProfileFetched(_repository.currentUser);
      } catch (e) {
        yield CurrentUserProfileFetchFailure(e.toString());
      }
    }
  }
}
