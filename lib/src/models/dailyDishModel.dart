import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

import '../enums/daySession.dart';
import 'dishModel.dart';

class DailyDishModel extends Equatable {
  DateTime _day;
  DaySession _session;
  int _storeId;
  DishModal _dish;
  UserModel _confirmBy;
  DateTime _confirmAt;

  DateTime get day => _day;

  DaySession get session => _session;

  int get storeId => _storeId;

  DishModal get dish => _dish;

  UserModel get confirmBy => _confirmBy;

  DateTime get confirmAt => _confirmAt;

  DailyDishModel.fromJson(Map<String, dynamic> parsedJson) {
    _day =
        parsedJson['day'] != null ? DateTime.tryParse(parsedJson['day']) : null;
    _session = DaySession(parsedJson['session']);
    _storeId = parsedJson['storeId'];
    _confirmBy = parsedJson['confirmBy'] != null
        ? UserModel.fromJson(parsedJson['confirmBy'])
        : null;
    _confirmAt = parsedJson['confirmAt'] != null
        ? DateTime.tryParse(parsedJson['confirmAt'])
        : null;
    print(parsedJson['dish']);
    _dish = DishModal.fromJson(parsedJson['dish']);
  }

  @override
  List<Object> get props => null;
}
