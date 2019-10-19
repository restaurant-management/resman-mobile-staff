import 'dart:convert';
import 'models/userModel.dart';
import 'models/billModel.dart';
import 'models/billDishModel.dart';
import 'models/dailyDishModel.dart';
import 'models/dishModel.dart';
class FakeData {
  UserModel user;
  BillModel bill;
  BillDishModel billDish;
  DailyDishModel dailyDish;
  DishModel dish;
  FakeData()
  {
    Map<String, dynamic> userJson = jsonDecode(
        '{"userId": 1,"uuid": "1","userName": "ThanhDuy","fullName": "Phan Thanh Duy","email": "abc@mail.com","password": "","avatar": "https://avatars0.githubusercontent.com/u/36978155?s=460&v=4","birthday": "1969-07-20 20:18:04Z","phoneNumber": "120382103821098","address": "abc","roles":[]}');
    user = UserModel.fromJson(userJson);
  }
}