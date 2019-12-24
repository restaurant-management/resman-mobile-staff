import 'package:bloc/bloc.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';

import 'event.dart';
import 'state.dart';

class BillBloc extends Bloc<BillBlocEvent, BillBlocState> {
  final Repository _repository = Repository();

  BillBloc();

  @override
  BillBlocState get initialState => BillBlocInitialize();

  @override
  Stream<BillBlocState> mapEventToState(BillBlocEvent event) async* {
    if (event is FetchAllBill) {
      yield BillBlocFetching();
      try {
        var listBill;
        listBill = await _repository.getAllBillStaff();
        yield BillBlocFetched(listBill);
      } catch (e) {
        yield BillBlocFetchFailure(e.toString());
      }
    }
  }
}
