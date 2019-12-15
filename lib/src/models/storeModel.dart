import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class StoreModel extends Equatable {
  String _name;

  String get name => _name;
  int _id;
  String _description;
  String _logo;
  String _address;
  String _hotLine;
  int _rating;
  DateTime _openTime;
  DateTime _closeTime;


  @override
  // TODO: implement props
  List<Object> get props => [_id];

  int get id => _id;

  String get description => _description;

  String get logo => _logo;

  String get address => _address;

  String get hotLine => _hotLine;

  int get rating => _rating;

  DateTime get openTime => _openTime;

  DateTime get closeTime => _closeTime;

  StoreModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson["id"];
    _name = parsedJson["name"];
    _logo = parsedJson["logo"];
    _address = parsedJson["address"];
    _hotLine = parsedJson["hotline"];
    _rating = parsedJson["rating"];
    _openTime = parsedJson["openTime"] != null
        ? DateFormat('HH:mm:ss').parse(parsedJson['openTime'])
        : null;
    _closeTime = parsedJson["closeTime"] != null
        ? DateFormat('HH:mm:ss').parse(parsedJson['closeTime'])
        : null;
  }
}