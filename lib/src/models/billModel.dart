import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

class BillModel extends Equatable {
  num _billId;
  UserModel _createBy;
  UserModel _preparedBy;
  UserModel _collectBy;
  int _customerId;
  int _tableNumber;
  DateTime _createAt;
  DateTime _prepareAt;
  DateTime _collectAt;
  List<BillDishModel> _dishes;

  BillModel.fromJson(Map<String, dynamic> json) {
    _createAt = DateTime.tryParse(json['createAt']);
    _prepareAt = DateTime.tryParse(json['prepareAt']);
    _collectAt = DateTime.tryParse(json['collectAt']);
  }

  String getStatus() {
    String status;
    do {
      if (_collectAt != null) {
        status = "Prepared";
        break;
      }
      if (_prepareAt != null) {
        status = "Preparing";
        break;
      }
      if (_createAt != null) {
        status = "Odered";
        break;
      }
      status = "Unknow";
    } while (false);
    return status;
  }

  @override
  List<Object> get props => null;

  num get billId => _billId;

  UserModel get createBy => _createBy;

  DateTime get collectAt => _collectAt;

  DateTime get prepareAt => _prepareAt;

  int get tableNumber => _tableNumber;

  int get customerId => _customerId;

  UserModel get collectBy => _collectBy;

  UserModel get preparedBy => _preparedBy;

  DateTime get createAt => _createAt;

  List<BillDishModel> get dishes => _dishes;

  BillModel()
  {
    _dishes = [];
  }
}
