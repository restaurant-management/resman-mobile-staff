import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/enums/permission.dart';

class RoleModel extends Equatable {

  int _rodeId;
  String _slug;
  String _name;
  String _description;
  int _level;
  List<Permission> _permission;


  @override
  // TODO: implement props
  List<Object> get props => null;

  int get rodeId => _rodeId;

  String get slug => _slug;

  String get name => _name;

  String get description => _description;

  int get level => _level;

  List<Permission> get permission => _permission;

  RoleModel.fromJson(Map<String, dynamic> parsedJson) {
    _slug = parsedJson['slug'];
    _name = parsedJson['name'];
    _description = parsedJson['description'];
    _level = parsedJson['level'];
    _permission = parsedJson['permission'] as List;
  }

}