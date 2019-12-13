import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';

class DishModal extends Equatable {
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

  DishModal.fromJson(Map<String, dynamic> parsedJson) {
    _dishId = parsedJson['id'];
    _name = parsedJson['name'];
    _description = parsedJson['description'];
    _images = (parsedJson['images'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    _defaultPrice = parsedJson['defaultPrice'];
  }

  @override
//  String toString() => '{dishId: $_dishId, name: $_name}';

  @override
  List<Object> get props => null;
}
