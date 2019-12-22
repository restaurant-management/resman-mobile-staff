import 'package:equatable/equatable.dart';
import '../../models/dailyDishModel.dart';

abstract class DailyDishState extends Equatable {
  DailyDishState([List props = const []]) : super();
}

class DailyDishInitialized extends DailyDishState {
  @override
  String toString() => 'DailyDishInitialized';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class DailyDishFetching extends DailyDishState {
  @override
  String toString() => 'DailyDishFetching';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class DailyDishFetched extends DailyDishState {
  final List<DailyDishModel> listDailyDish;

  DailyDishFetched(this.listDailyDish) : super([listDailyDish]);

  @override
  String toString() => 'DailyDishFetched';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class DailyDishFetchFailure extends DailyDishState {
  final String error;

  DailyDishFetchFailure(this.error) : super([error]);

  @override
  String toString() => 'DailyDishFetchFailure {error: $error}';

  @override
  // TODO: implement props
  List<Object> get props => null;
}