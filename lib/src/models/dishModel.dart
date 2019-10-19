import 'package:equatable/equatable.dart';

class DishModel extends Equatable {
  int _dishId;
  String _name;
  String _description;
  List<String> _images;
  int _defaultPrice;

  int get dishId => _dishId;

  String get name => _name;

  String get description => _description;

  List<String> get images => _images;

  int get defaultPrice => _defaultPrice;

  DishModel.fromJson(Map<String, dynamic> parsedJson) {
    _dishId = parsedJson['dishId'];
    _name = parsedJson['name'];
    _description = parsedJson['description'];
    _images = (parsedJson['images'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    _defaultPrice = parsedJson['defaultPrice'];
  }

//  static List<DishModal> fromDishesJsonString(String jsonString) {
//
//  }

  @override
  String toString() => '{dishId: $_dishId, name: $_name}';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
