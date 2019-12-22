import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:resman_mobile_staff/src/models/storeModel.dart';
import 'roleModel.dart';

class UserModel extends Equatable {
  int _userId;
  List<StoreModel> _stores;
  String _uuid;
  String _username;
  String _fullName;
  String _avatar;
  String _email;
  DateTime _birthday;
  String _phoneNumber;
  String _address;
  List<RoleModel> _roles;
  int _point;

  int get userId => _userId;

  List<StoreModel> get stores => _stores;

  String get uuid => _uuid;

  String get username => _username;

  String get fullName => _fullName;

  String get avatar => _avatar;

  String get email => _email;

  DateTime get birthday => _birthday;

  String get phoneNumber => _phoneNumber;

  String get address => _address;

  List<RoleModel> get roles => _roles;

  int get point => _point;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _uuid = parsedJson['uuid'];
    _username = parsedJson['username'];
    _fullName = parsedJson['fullName'];
    _avatar = parsedJson['avatar'];
    _email = parsedJson['email'];
    _phoneNumber = parsedJson['phoneNumber'];
    _address = parsedJson['address'];
    _birthday = parsedJson['birthday'] != null
        ? DateFormat('yyyy-MM-dd').parse(parsedJson['birthday'])
        : null;
    _point = parsedJson['point'];
    // Parse complex json
    var listRole = parsedJson['roles'] as List ?? [];
    _roles = listRole.isNotEmpty
        ? listRole.map((i) => RoleModel.fromJson(i)).toList()
        : [];
    var listStore = parsedJson['stores'] as List ?? [];
    _stores = listStore.isNotEmpty
        ? listStore.map((i) => StoreModel.fromJson(i)).toList()
        : [];
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
  List<Object> get props => null;
}
