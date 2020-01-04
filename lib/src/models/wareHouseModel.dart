import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/warehouseStock.dart';

class WarehouseModel extends Equatable {
  String _address;
  String _description;
  String _hotline;
  int _id;
  List<WarehouseStock> _warehouseStocks;

  @override
  // TODO: implement props
  List<Object> get props => null;
}
