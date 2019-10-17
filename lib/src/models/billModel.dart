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

    int get collectValue => _collectValue;


    BillModel.fromJson(Map<String, dynamic> json) {
      _billId = json['billId'];
      _collectValue = json['collectValue'];
    }

  @override
  List<Object> get props => null;
}