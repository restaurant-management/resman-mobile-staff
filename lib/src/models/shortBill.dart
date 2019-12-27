import 'package:equatable/equatable.dart';

class ShortBill extends Equatable {
  int _billId;
  int _tableNumber;
  int _amountPreparedDishes;
  String _status;

  ShortBill.fromJson(Map<String, dynamic> parsedJson) {
    _billId = parsedJson["billId"];
    _tableNumber = parsedJson["tableNumber"];
    _amountPreparedDishes = parsedJson["amountPreparedDishes"];
    _status = parsedJson["status"];
  }

  @override
  // TODO: implement props
  List<Object> get props => [_billId];

  int get billId => _billId;

  String get status => _status;

  int get amountPreparedDishes => _amountPreparedDishes;

  int get tableNumber => _tableNumber;
}
