import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';

class BillDishModel extends Equatable {
  int _billHistoryId;
  String _note;
  DateTime _preparedAt;
  DateTime _deliveryAt;
  int _quantity;
  int _price;
  DishModal _dish;

  int get billHistoryId => _billHistoryId;

  String get note => _note;

  DateTime get preparedAt => _preparedAt;

  DateTime get deliveryAt => _deliveryAt;

  int get quantity => _quantity;

  int get price => _price;

  DishModal get dish => _dish;

  BillDishModel.fromJson(Map<String, dynamic> json) {
    _billHistoryId = json["billHistoryId"];
    _note = json["note"];
    _preparedAt = DateTime.tryParse(json["preparedAt"]);
    _deliveryAt = DateTime.tryParse(json["deliveryAt"]);
    _quantity = json["quantity"];
    _price = json["price"];
    _dish = DishModal.fromJson(json["dish"]);
//    List<dynamic> dishDetail = json["dish"];
//    _dish = [];
//    for(int i=0; i<dishDetail.length; i++)
//      {
//        _dish.add(DishModal.fromJson(dishDetail[i]));
//      }
  }

  @override
  String toString() {
    return '{billHistory: $_billHistoryId, note: $_note}';
  }

  @override
  List<Object> get props => [_billHistoryId];
}
