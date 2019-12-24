import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';

abstract class BillItemState extends Equatable {
  BillItemState([List props = const []]) : super();
}

class BillItemInitialize extends BillItemState {
  @override
  String toString() => 'BillItemInitialize';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BillItemUpdatingStatus extends BillItemState {
  final BillModel bill;

  BillItemUpdatingStatus(this.bill) : super([bill]);

  @override
  String toString() => 'BillItemUpdatingStatus';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BillItemUpdatedStatus extends BillItemState {
  @override
  String toString() => 'BillItemUpdatedStatus';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BillItemUpdateStatusFailure extends BillItemState {
  final String error;

  BillItemUpdateStatusFailure(this.error) : super([error]);

  @override
  String toString() => 'BillItemUpdateStatusFailure ($error)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
