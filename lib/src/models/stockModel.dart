import 'package:equatable/equatable.dart';

class StockModel extends Equatable {
  String _name;
  int _price;
  int _remain;
  String _unit;
  List<String> _images;

  String get name => _name;

  int get price => _price;

  int get remain => _remain;

  String get unit => _unit;

  List<String> get images => _images;

  StockModel.fromJson(Map<String, dynamic> parsedJson) {
    _name = parsedJson["name"];
    _price = parsedJson["price"];
    _remain = parsedJson["remain"];
    _unit = parsedJson["unit"];
    _images = (parsedJson['images'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
  }

  @override
  // TODO: implement props
  List<Object> get props => [_name];
}
