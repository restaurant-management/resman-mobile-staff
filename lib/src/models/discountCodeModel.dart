import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/storeModel.dart';

class DiscountCodeModel extends Equatable {
  String _code;
  bool _isActive;
  String _name;
  String _description;
  DateTime _startAt;
  DateTime _endAt;
  double _minBillPrice;
  double _maxPriceDiscount;
  int _discount;

  DiscountCodeModel.fromJson(Map<String, dynamic> jsonParsed) {
    _code = jsonParsed["code"];
    _isActive = jsonParsed["isActive"];
    _description = jsonParsed["description"];
    _startAt =
        jsonParsed["startAt"] ? DateTime.tryParse(jsonParsed["startAt"]) : null;
    _endAt =
        jsonParsed["endAt"] ? DateTime.tryParse(jsonParsed["endAt"]) : null;
    _minBillPrice = jsonParsed["minBillPrice"];
    _maxPriceDiscount = jsonParsed["maxPriceDiscount"];
    _discount = jsonParsed["discount"];
  }

  @override
  // TODO: implement props
  List<Object> get props => null;

  String get code => _code;

  bool get isValid => _isActive;

  String get name => _name;

  String get description => _description;

  DateTime get startAt => _startAt;

  DateTime get endAt => _endAt;

  double get minBillPrice => _minBillPrice;

  double get maxPriceDiscount => _maxPriceDiscount;

  int get discount => _discount;
}
