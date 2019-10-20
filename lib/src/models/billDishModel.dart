import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';

class BillDishModel extends Equatable {
  int _billHistoryId;
  String _note;
  DateTime _preparedAt;
  DateTime _delivaryAt;
  int _quantily;
  int _price;
  DishModal _dish;

  int get billHistoryId => _billHistoryId;

  String get note => _note;

  DateTime get preparedAt => _preparedAt;

  DateTime get delivaryAt => _delivaryAt;

  int get quantily => _quantily;

  int get price => _price;

  DishModal get dish => _dish;

  BillDishModel.fromJson(Map<String, dynamic> json) {
    _billHistoryId = json["billHistoryId"];
    _note = json["note"];
    _preparedAt = DateTime.parse(json["preparedAt"]);
    _delivaryAt = DateTime.parse(json["delivaryAt"]);
    _quantily = json["quantily"];
    _price = json["price"];
    _dish = DishModal.fromJson(json["dish"]);
  }

  @override
  String toString() {
    return '{billHistory: $_billHistoryId, note: $_note, name: ${dish.name}}';
  }

  @override
  List<Object> get props => null;
}
