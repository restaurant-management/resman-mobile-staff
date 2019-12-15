import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';

abstract class BillBlocState extends Equatable {
  BillBlocState([List props = const []]) : super();
}

class BillBlocInitialize extends BillBlocState {
  @override
  String toString() => 'BillBlocInitialize';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BillBlocFetching extends BillBlocState {
  @override
  String toString() => 'BillBlocFetching';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BillBlocFetched extends BillBlocState {
  final List<BillModel> listBills;

  BillBlocFetched(this.listBills) : super([listBills]);

  @override
  String toString() => 'BillBlocFetched ${listBills.length} bills';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BillBlocFetchFailure extends BillBlocState {
  final String error;

  BillBlocFetchFailure(this.error) : super([error]);

  @override
  String toString() => 'BillBlocFetchFailure {error: $error}';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
