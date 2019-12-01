import 'package:equatable/equatable.dart';

abstract class CurrentUserEvent extends Equatable {
  CurrentUserEvent([List props = const []]) : super();
}

class FetchCurrentUserProfile extends CurrentUserEvent {
  @override
  String toString() => 'FetchCurrentUserProfile';

  @override
  List<Object> get props => null;

}

class GetAllCurrentUserPermissions extends CurrentUserEvent {
  @override
  String toString() => 'GetAllCurrentUserPermissions';

  @override
  List<Object> get props => null;
}
