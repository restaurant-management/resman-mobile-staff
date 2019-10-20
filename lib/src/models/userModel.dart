import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'roleModel.dart';

class UserModel extends Equatable {
  int _userId;
  String _uuid;
  String _username;
  String _fullName;
  String _avatar;
  String _email;
  DateTime _birthday;
  String _phoneNumber;
  List<RoleModel> _roles;
  int _point;

  int get userId => _userId;

  String get uuid => _uuid;

  String get username => _username;

  String get fullName => _fullName;

  String get avatar => _avatar;

  String get email => _email;

  DateTime get birthday => _birthday;

  String get phoneNumber => _phoneNumber;

  List<RoleModel> get roles => _roles;

  int get point => _point;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _userId = parsedJson["userId"];
    _uuid = parsedJson['uuid'];
    _username = parsedJson['userName'];
    _fullName = parsedJson['fullName'];
    _avatar = parsedJson['avatar'];
    _email = parsedJson['email'];
    _phoneNumber = parsedJson['phoneNumber'];
    _birthday = parsedJson['birthday'] != null
        ? DateFormat('yyyy-MM-dd').parse(parsedJson['birthday'])
        : null;
    _point = parsedJson['point'];
    // Parse complex json
    // var listRole = parsedJson['role'] as List;
    // _roles = listRole.map((i) => RoleModel.fromJson(i)).toList();
  }

  UserModel.empty() {
    _uuid = '';
    _username = 'username';
    _fullName = 'fullName';
    _avatar = '';
    _email = 'email@gmail.com';
    _birthday = DateTime.now();
    _phoneNumber = '';
    _point = 0;
    _roles = [];
  }

  @override
  String toString() {
    return '{uuid: $uuid, username: $username, fullname: $fullName, email: $email, birthday: $birthday, point: $point, role $roles}';
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
