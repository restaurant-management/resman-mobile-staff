import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

abstract class EditProfileBlocEvent extends Equatable {
  EditProfileBlocEvent([List props = const []]) : super();
}

class SaveNewProfile extends EditProfileBlocEvent {
  final UserModel currentUser;
  final String newFullName;
  final DateTime newBirthday;
  final String newEmail;
  final File newAvatar;

  SaveNewProfile(this.currentUser, this.newFullName, this.newBirthday,
      this.newEmail, this.newAvatar)
      : super([currentUser, newFullName, newBirthday, newEmail, newAvatar]);

  @override
  String toString() => 'SaveNewProfile';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
