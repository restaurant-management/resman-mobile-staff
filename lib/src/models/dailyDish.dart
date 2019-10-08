import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'dishModel.dart';
import '../enums/daySession.dart';

class DailyDish extends Equatable {
  DateTime _day;
  DaySession _session;
  int _storeId;
  DishModal _dish;
  int _confirmBy;
  DateTime _confirmAt;

  DateTime get day => _day;

  DaySession get session => _session;

  int get storeId => _storeId;

  DishModal get dish => _dish;

  int get confirmBy => _confirmBy;

  DateTime get confirmAt => _confirmAt;

  DailyDish.fromJson(Map<String, dynamic> parsedJson) {
    _day = DateTime.parse(parsedJson['day']);
    _session = DaySession(parsedJson['session']);
    _storeId = parsedJson['storeId'];
    _confirmBy = parsedJson['confirmBy'];
    _confirmAt = DateTime.parse(parsedJson['confirmAt']);
    print(parsedJson['dishes']);
    _dish = DishModal.fromJson(parsedJson['dishes']);
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
