import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

abstract class EditProfileBlocState extends Equatable {
  EditProfileBlocState([List props = const []]) : super();
}

class EditProfileBlocInitialize extends EditProfileBlocState {
  final UserModel currentUser;

  EditProfileBlocInitialize(this.currentUser) : super([currentUser]);

  @override
  String toString() => 'EditProfileBlocInitialize (${currentUser.username})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class EditProfileBlocUploadingAvatar extends EditProfileBlocState {
  @override
  String toString() => 'EditProfileBlocUploadingAvatar';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class EditProfileBlocUploadedAvatar extends EditProfileBlocState {
  @override
  String toString() => 'EditProfileBlocUploadedAvatar';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class EditProfileBlocSaving extends EditProfileBlocState {
  final UserModel currentUser;
  final String newFullName;
  final DateTime newBirthday;
  final String newEmail;

  EditProfileBlocSaving(
      this.currentUser, this.newFullName, this.newBirthday, this.newEmail)
      : super([currentUser, newFullName, newBirthday, newEmail]);

  @override
  String toString() =>
      'EditProfileBlocSaving ${currentUser.username} ($newFullName, $newEmail, $newBirthday)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class EditProfileBlocSaved extends EditProfileBlocState {
  final UserModel savedUser;

  EditProfileBlocSaved(this.savedUser) : super([savedUser]);

  @override
  String toString() => 'EditProfileBlocSaved';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class EditProfileBlocSaveFailure extends EditProfileBlocState {
  final String error;

  EditProfileBlocSaveFailure(this.error) : super([error]);

  @override
  String toString() => 'EditProfileBlocSaveFailure (error: $error)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class EditProfileBlocUploadAvatarFailure extends EditProfileBlocState {
  final String error;

  EditProfileBlocUploadAvatarFailure(this.error) : super([error]);

  @override
  String toString() => 'EditProfileBlocUploadAvatarFailure (error: $error)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
