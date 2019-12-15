import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/storeModel.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

class BillModel extends Equatable {
  int _id;
  DateTime _deleteAt;
  int _tableNumber;
  DateTime _insertAt;
  DateTime _createAt;
  DateTime _prepareAt;
  DateTime _collectAt;
  int _collectValue;
  String _voucherCode;
  double _voucherValue;
  bool _voucherIsPercent;
  String _discountCode;
  double _discountValue;
  double _rating;
  String _note;
  UserModel _createBy;
  StoreModel _store;
  DateTime _updateAt;
  UserModel _updateBy;
  List<BillDishModel> _dishes;


  BillModel.fromJson(Map<String, dynamic> json) {
    _updateAt = json['updateAt'] != null
        ? DateTime.parse(json['updateAt'])
        : null;
    _insertAt = json['insertAt'] != null
        ? DateTime.parse(json['insertAt'])
        : null;
    _deleteAt = json['deleteAt'] != null
        ? DateTime.parse(json['deleteAt'])
        : null;
    _createAt = json['createAt'] != null
        ? DateTime.parse(json['createAt'])
        : null;
    _prepareAt = json['prepareAt'] != null
        ? DateTime.parse(json['prepareAt'])
        : null;
    _collectAt = json['collectAt'] != null
        ? DateTime.parse(json['collectAt'])
        : null;
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

  int get id => _id;

  DateTime get deleteAt => _deleteAt;

  int get tableNumber => _tableNumber;

  DateTime get insertAt => _insertAt;

  DateTime get createAt => _createAt;

  DateTime get prepareAt => _prepareAt;

  DateTime get collectAt => _collectAt;

  int get collectValue => _collectValue;

  String get voucherCode => _voucherCode;

  double get voucherValue => _voucherValue;

  bool get voucherIsPercent => _voucherIsPercent;

  String get discountCode => _discountCode;

  double get discountValue => _discountValue;

  double get rating => _rating;

  String get note => _note;

  UserModel get createBy => _createBy;

  StoreModel get store => _store;

  DateTime get updateAt => _updateAt;

  UserModel get updateBy => _updateBy;

  List<BillDishModel> get dishes => _dishes;

  BillModel();
}
