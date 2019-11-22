import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

class BillModel extends Equatable {
  int _billId;
  UserModel _createBy;
  UserModel _preparedBy;
  UserModel _collectBy;
  int _customerId;
  int _tableNumber;
  DateTime _createAt;
  DateTime _prepareAt;
  DateTime _collectAt;
  int _collectValue;

  int get billId => _billId;

  DateTime get createAt => _createAt;

  int get collectValue => _collectValue;

  BillModel.fromJson(Map<String, dynamic> json) {
    _billId = json['billId'];
    _createAt = DateTime.tryParse(json['createAt']);
    _prepareAt = DateTime.tryParse(json['prepareAt']);
    _collectAt = DateTime.tryParse(json['collectAt']);
    _collectValue = json['collectValue'];
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
}
