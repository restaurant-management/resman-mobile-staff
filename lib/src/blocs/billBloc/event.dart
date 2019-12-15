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
