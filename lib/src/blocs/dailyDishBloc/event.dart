import 'package:equatable/equatable.dart';

abstract class DailyDishEvent extends Equatable {
  DailyDishEvent([List props = const []]) : super();
}

class FetchDailyDish extends DailyDishEvent {
  @override
  String toString() => 'FetchDailyDish';

  @override
  // TODO: implement props
  List<Object> get props => null;
}