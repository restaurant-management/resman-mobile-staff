import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:resman_mobile_staff/src/common/EnvVariables.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/models/discountCodeModel.dart';

import '../graphClient.dart';
import '../graphQuery.dart';

class BillProvider {
  static String apiUrl = EnvVariables.apiUrl;
  Client client = Client();

  Future<List<BillModel>> getAllStaff(String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    var day = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final response =
        await client.get('$apiUrl/api/bills?day=$day', headers: headers);
    if (response.statusCode == 200) {
      List<BillModel> result = [];
      List<dynamic> list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        var billModel = BillModel.fromJson(list[i]);
        result.add(billModel);
      }
      return result;
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi tải danh sách hoá đơn.');
    }
  }

  Future<List<BillModel>> getAllChef(String token) async {
    final data = await (GraphClient()
          ..authorization(token)
          ..addBody(GraphQuery.getAllBillChef()))
        .connect();

    List<BillModel> listBill = List<BillModel>();
    Iterable i = data["todayAllBillsByChef"]["bills"] as List;
    List<BillModel> list = i.map((model) => BillModel.fromJson(model)).toList();
    list.forEach((bill) {
      listBill.add(bill);
    });

    return listBill;
  }

  Future<List<BillModel>> getAllUserBills(String token, String username) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response =
        await client.get('$apiUrl/api/bills/user/$username', headers: headers);
    if (response.statusCode == 200) {
      List<BillModel> result = [];
      List<dynamic> list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        var billModel = BillModel.fromJson(list[i]);
        result.add(billModel);
      }
      return result;
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi tải danh sách hoá đơn.');
    }
  }

  Future<BillModel> createBill(int storeId, String token, int tableNumber,
      List<int> dishIds, List<String> dishNotes, List<int> dishQuantities,
      {String note,
      String voucherCode,
      String discountCode,
      String customerUuid,
      double rating}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token
    };
    Map<String, dynamic> data = {
      "storeId": storeId,
      "tableNumber": tableNumber,
      "dishIds": dishIds,
      "dishNotes": dishNotes,
      "dishQuantities": dishQuantities,
      "voucherCode": voucherCode,
      "discountCode": discountCode,
      "note": note,
      "customerUuid": customerUuid,
      "rating": rating
    };

    var body = jsonEncode(data);

    final response = await client.post('$apiUrl/api/bills/restrict',
        body: body, headers: headers);
    if (response.statusCode != 200) {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Tạo hoá đơn thất bại.');
    } else {
      return BillModel.fromJson(jsonDecode(response.body));
    }
  }

  Future<BillModel> getBill(String token, int billId) async {
    final data = await (GraphClient()
      ..authorization(token)
      ..addBody(GraphQuery.getBillById(billId)))
        .connect();

    return BillModel.fromJson(data['getBill']);
  }

  Future<BillModel> updatePaidBillStatus(String token, int billId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response =
        await client.put('$apiUrl/api/bills/$billId/paid', headers: headers);
    if (response.statusCode == 200) {
      return BillModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi cập nhật thanh toán hoá đơn.');
    }
  }

  Future<BillModel> updatePreparingBillStatus(String token, int billId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client.put('$apiUrl/api/bills/$billId/preparing',
        headers: headers);
    if (response.statusCode == 200) {
      return BillModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi cập nhật đang chuẩn bị hoá đơn.');
    }
  }

  Future<BillModel> updatePrepareDoneBillStatus(
      String token, int billId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client.put('$apiUrl/api/bills/$billId/prepare-done',
        headers: headers);
    if (response.statusCode == 200) {
      return BillModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi cập nhật đã chuẩn bị xong hoá đơn.');
    }
  }

  Future<BillModel> updateDeliveringBillStatus(String token, int billId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client.put('$apiUrl/api/bills/$billId/delivering',
        headers: headers);
    if (response.statusCode == 200) {
      return BillModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi cập nhật đang giao hoá đơn.');
    }
  }

  Future<BillModel> updateShippingBillStatus(String token, int billId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client.put('$apiUrl/api/bills/$billId/shipping',
        headers: headers);
    if (response.statusCode == 200) {
      return BillModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi cập nhật đang ship hoá đơn.');
    }
  }

  Future<BillModel> updateCompleteBillStatus(String token, int billId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client.put('$apiUrl/api/bills/$billId/complete',
        headers: headers);
    if (response.statusCode == 200) {
      return BillModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi cập nhật hoàn thành hoá đơn.');
    }
  }

  Future<DiscountCodeModel> validDiscountCode(
      String token, String discountValue) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client
        .get('$apiUrl/api/discount_codes/$discountValue', headers: headers);
    if (response.statusCode == 200) {
      return DiscountCodeModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Có lỗi xảy ra khi xác thực hóa đơn.');
    }
  }

  Future<BillModel> prepareBill(String token, int billId) async {
    final data = await (GraphClient()
          ..authorization(token)
          ..addBody(GraphQuery.prepareBill(billId)))
        .connect();

    return BillModel.fromJson(data['prepareBill']);
  }
}
