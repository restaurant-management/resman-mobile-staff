import 'dart:convert';

import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';
import 'package:resman_mobile_staff/src/models/userModel.dart';

class FakeData {
  static Map<String, dynamic> userJson = jsonDecode(
      '{"userId": 1,"uuid": "1","userName": "ThanhDuy","fullName": "Phan Thanh Duy","email": "abc@mail.com","password": "123","avatar": "https://avatars0.githubusercontent.com/u/36978155?s=460&v=4","birthday": "1969-07-20 20:18:04Z","phoneNumber": "120382103821098","address": "abc","roles":[{"slug":"update-paid-bill-status","name":"staff","description":"abczyx","level":3,"permission":["update-paid-bill-status"]}]}');
  static UserModel user = UserModel.fromJson(userJson);

  static const jsonParsed =
      '{"billHistoryId":1,"note":"Khong bo hanh","preparedAt":"1969-07-20 20:18:04Z","deliveryAt":"1969-07-20 20:18:04Z","quantity":5,"price":10000,"dish":{"dishId":10,"name":"Chao ga","description":"abcsaca","defaultPrice":20000,"images":["https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2018/08/24/e46c807ef357438e9d1f7f53682cc2e6_Elements_Hokkaido+Kozatsu+Beef.jpg"]}}';
  static const billJson =
      '{"billId":1,"createBy":"","preparedBy":"","collectBy":"","customerId":"","tableNumber":"","createAt":"1969-07-20 20:18:04Z","prepareAt":"1969-07-20 20:18:04Z","collectAt":"","collectValue":10}';

  static BillDishModel billDish =
      BillDishModel.fromJson(jsonDecode(jsonParsed));
  static List<BillDishModel> billDishes = [
    billDish,
    billDish,
    billDish,
  ];
  static BillModel bill = BillModel.fromJson(jsonDecode(billJson));

  static Map<String, dynamic> dailyDishString = jsonDecode(
      '{"day":"1969-07-20 20:18:04Z","session": "morning","storeId": 1,"confirmBy": 1,"confirmAt": "1969-07-20 20:18:04Z","dishes": {"dishId": 1,"name": "Ca kho","description": "acascc","images": ["https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2018/08/24/e46c807ef357438e9d1f7f53682cc2e6_Elements_Hokkaido+Kozatsu+Beef.jpg"]}}');
  static DailyDishModel dailyDish = DailyDishModel.fromJson(dailyDishString);
  static List<DailyDishModel> listDailyDish = [
    dailyDish,
    dailyDish,
    dailyDish,
    dailyDish,
    dailyDish,
    dailyDish
  ];
  static List<CartDishModel> listCart = [
    CartDishModel.fromDailyDish(dailyDish),
    CartDishModel.fromDailyDish(dailyDish),
    CartDishModel.fromDailyDish(dailyDish),
    CartDishModel.fromDailyDish(dailyDish),
  ];

  static Map<String, dynamic> dishString = jsonDecode(
      '{"dishId": 1,"name": "Ca kho","description": "acascc","images": ["https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2018/08/24/e46c807ef357438e9d1f7f53682cc2e6_Elements_Hokkaido+Kozatsu+Beef.jpg"]}');
  static DishModal dish = DishModal.fromJson(dishString);
  static List<DishModal> listDish = [
    dish,
    dish,
    dish,
    dish,
    dish,
    dish
  ];
}
