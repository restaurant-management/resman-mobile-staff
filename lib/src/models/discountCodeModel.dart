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
  double _discount;

  DiscountCodeModel.fromJson(Map<String, dynamic> jsonParsed) {
    _code = jsonParsed["code"];
    _isActive = jsonParsed["isActive"];
    print(jsonParsed["description"]);
    _description = jsonParsed["description"];
    _startAt = (jsonParsed["startAt"] != null &&
            jsonParsed["startAt"].toString().isNotEmpty)
        ? DateTime.tryParse(jsonParsed["startAt"])
        : null;
    _endAt = (jsonParsed["endAt"] != null &&
            jsonParsed["endAt"].toString().isNotEmpty)
        ? DateTime.tryParse(jsonParsed["endAt"])
        : null;
    _minBillPrice = double.tryParse(jsonParsed["minBillPrice"].toString());
    _maxPriceDiscount = double.tryParse(jsonParsed["maxPriceDiscount"].toString());
    _discount = double.tryParse(jsonParsed["discount"].toString());
  }

  @override
  // TODO: implement props
  List<Object> get props => null;

  String get code => _code;

  bool get isActive => _isActive;

  String get name => _name;

  String get description => _description;

  DateTime get startAt => _startAt;

  DateTime get endAt => _endAt;

  double get minBillPrice => _minBillPrice;

  double get maxPriceDiscount => _maxPriceDiscount;

  double get discount => _discount;
}
