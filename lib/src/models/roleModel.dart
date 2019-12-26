import 'package:equatable/equatable.dart';

class RoleModel extends Equatable {
  int _rodeId;
  String _slug;
  String _name;
  String _description;
  int _level;

  @override
  List<Object> get props => null;

  int get rodeId => _rodeId;

  String get slug => _slug;

  String get name => _name;

  String get description => _description;

  int get level => _level;

  RoleModel.fromJson(Map<String, dynamic> parsedJson) {
    _slug = parsedJson['slug'];
    _name = parsedJson['name'];
    _description = parsedJson['description'];
    _level = parsedJson['level'];
  }
}
