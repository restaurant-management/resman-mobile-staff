import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

abstract class CurrentUserState extends Equatable {
  CurrentUserState([List props = const []]) : super();
}

class CurrentUserProfileEmpty extends CurrentUserState {
  @override
  String toString() => 'CurrentUserProfileEmpty';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CurrentUserProfileFetching extends CurrentUserState {
  @override
  String toString() => 'FetchingCurrentUserProfile';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CurrentUserProfileFetched extends CurrentUserState {
  final UserModel user;

  CurrentUserProfileFetched(this.user) : super([user]);

  @override
  String toString() => 'CurrentUserProfileFetched';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CurrentUserProfileFetchFailure extends CurrentUserState {
  final String error;

  CurrentUserProfileFetchFailure(this.error) : super([error]);

  @override
  String toString() => 'CurrentUserProfileFetchFailure {error: $error}';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
