import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/blocs/billBloc/bloc.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';

abstract class BillItemEvent extends Equatable {
  BillItemEvent([List props = const []]) : super();
}

class PayBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  PayBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'PayBill (${bill.id})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PrepareBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  PrepareBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'PrepareBill (${bill.id})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FinishPrepareBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  FinishPrepareBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'FinishPrepareBill (${bill.id})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class DeliveryBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  DeliveryBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'DeliveryBill (${bill.id})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FinishDeliveryBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  FinishDeliveryBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'FinishDeliveryBill (${bill.id})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
