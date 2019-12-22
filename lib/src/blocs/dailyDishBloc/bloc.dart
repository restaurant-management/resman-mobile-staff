import 'package:bloc/bloc.dart';
import '../../repositories/reponsitory.dart';

import 'event.dart';
import 'state.dart';

class DailyDishBloc extends Bloc<DailyDishEvent, DailyDishState> {
  final Repository _repository = Repository();

  DailyDishBloc._internal();

  static DailyDishBloc _singleton = DailyDishBloc._internal();

  factory DailyDishBloc(){
    return _singleton;
  }

  @override
  DailyDishState get initialState => DailyDishInitialized();

  @override
  Stream<DailyDishState> mapEventToState(DailyDishEvent event) async* {
    if (event is FetchDailyDish) {
      yield DailyDishFetching();
      try {
        var listDailyDish = await _repository.fetchDailyDishes();
        yield DailyDishFetched(listDailyDish);
      } catch (e) {
        yield DailyDishFetchFailure(e.toString());
      }
    }
  }
}
