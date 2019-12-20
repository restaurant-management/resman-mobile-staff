import 'package:bloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/billBloc/event.dart';
import 'package:resman_mobile_staff/src/blocs/billItemBloc/state.dart';
import 'package:resman_mobile_staff/src/enums/billStatus.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';

import 'event.dart';

class BillItemBloc extends Bloc<BillItemEvent, BillItemState> {
  final Repository _repository = Repository();

  @override
  BillItemState get initialState => BillItemInitialize();

  @override
  Stream<BillItemState> mapEventToState(BillItemEvent event) async* {
    try {
      if (event is PayBill ||
          event is PrepareBill ||
          event is FinishPrepareBill ||
          event is DeliveryBill ||
          event is FinishDeliveryBill) {
        if (event is PayBill) {
          yield BillItemUpdatingStatus(event.bill);
//          await _repository.updatePaidBillStatus(event.bill.billId);
          event.billBloc.add(FetchAllBill());
        }
        if (event is PrepareBill) {
          yield BillItemUpdatingStatus(event.bill);
//          await _repository.updatePreparingBillStatus(event.bill.billId);
          event.billBloc.add(FetchAllBill());
        }
        if (event is FinishPrepareBill) {
          yield BillItemUpdatingStatus(event.bill);
//          await _repository.updatePrepareDoneBillStatus(event.bill.billId);
          event.billBloc.add(FetchAllBill());
        }
        if (event is DeliveryBill) {
          yield BillItemUpdatingStatus(event.bill);
//          await _repository.updateDeliveringBillStatus(event.bill.billId);
          event.billBloc.add(FetchAllBill());
        }
        if (event is FinishDeliveryBill) {
          yield BillItemUpdatingStatus(event.bill);
//          await _repository.updateCompleteBillStatus(event.bill.billId);
          event.billBloc.add(FetchAllBill());
        }
        yield BillItemUpdatedStatus();
      }
    } catch (e) {
      yield BillItemUpdateStatusFailure(e.toString());
    }
  }
}
