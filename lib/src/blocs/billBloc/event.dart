import 'package:equatable/equatable.dart';

abstract class BillBlocEvent extends Equatable {
  BillBlocEvent([List props = const []]) : super();
}

class FetchAllBill extends BillBlocEvent {
  @override
  String toString() => 'FetchAllBill';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UpdateDiscountCode extends BillBlocEvent {
  final String _discountCode;

  UpdateDiscountCode(this._discountCode);

  @override
  String toString() => 'UpdateDiscountCode';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UpdateVoucherCode extends BillBlocEvent {
  final String _voucherCode;

  UpdateVoucherCode(this._voucherCode);

  @override
  String toString() => 'UpdateVoucherCode';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
