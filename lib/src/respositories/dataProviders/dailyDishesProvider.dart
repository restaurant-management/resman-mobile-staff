import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:resman_mobile_staff/src/common/EnvVariables.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../models/userModel.dart';

class DailyDishProvider {
  static String apiUrl = EnvVariables.apiUrl;
  Client client = Client();

  Future<List<DailyDishModel>> getAll() async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': (await SharedPreferences.getInstance()).getString(EnvVariables.PrepsTokenKey),
    };
    final response =
    await client.get('$apiUrl/api/daily_dishes/today?storeId=1', headers: headers);
    if (response.statusCode == 200) {
      List<DailyDishModel> result = [];
      List<dynamic> list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        var dailyDish = DailyDishModel.fromJson(list[i]);
        result.add(dailyDish);
      }
      return result;
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Tải danh sách món ăn thất bại.');
    }
  }
}
