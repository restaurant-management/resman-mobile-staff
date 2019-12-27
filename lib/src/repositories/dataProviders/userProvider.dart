import 'dart:convert';

import 'package:http/http.dart';
import 'package:resman_mobile_staff/src/common/EnvVariables.dart';

import '../../models/userModel.dart';
import '../graphClient.dart';
import '../graphQuery.dart';

class UserProvider {
  static String apiUrl = EnvVariables.apiUrl;
  Client client = Client();

  Future<String> login(String usernameOrEmail, String password) async {
    print('Login...');
    final response = await client.post('$apiUrl/api/users/login?lang=vi',
        body: {'usernameOrEmail': usernameOrEmail, 'password': password});
    print(response.body);
    if (response.statusCode == 200) {
      final token = response.body.toString().replaceAll('"', '');
      return token;
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Đăng nhập thất bại.');
    }
  }

  Future<void> register(String username, String email, String password) async {
    print('Register...');
    final response = await client.post('$apiUrl/api/users/register',
        body: {'username': username, 'password': password, 'email': email});
    if (response.statusCode != 200) {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Đăng ký thất bại.');
    }
  }

  Future<UserModel> getProfileByUsername(String username, String token) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client.get(
        '$apiUrl/api/users/$username?withRoles=true&&withStores=true&withWarehouse=false',
        headers: headers);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Đăng nhập thất bại.');
    }
  }

  Future<UserModel> getProfileByEmail(String email, String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response =
        await client.get('$apiUrl/api/users/email/34', headers: headers);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Đăng nhập thất bại.');
    }
  }

  Future<UserModel> editUserProfile(String token, String username, String phoneNumber, String address,
      String fullName, DateTime birthday, String avatar) async {
    final data = await (GraphClient()
      ..authorization(token)
      ..addBody(GraphQuery.changeProfile(
          fullName: fullName, avatar: avatar, birthday: birthday, address: address, phoneNumber: phoneNumber)))
        .connect();

    return UserModel.fromJson(data['changeProfileAsUser']);
  }

  Future changePassword(
      String token, String oldPassword, String newPassword) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    String query =
        'mutation {   changePasswordAsUser(newPassword: "$newPassword", oldPassword: "$oldPassword") }';
    Map<String, String> body = {};
    body.addAll({'query': query});
    final response = await client.post(
      EnvVariables.graphServer,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      String message;
      try {
        message = jsonDecode(response.body);
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw (message);
      throw ('Sửa mật khẩu thất bại.');
    } else {
      var data = jsonDecode(response.body)["data"];
      var errors = jsonDecode(response.body)["errors"];
      if (errors != null) {
        throw (errors[0]['message'] ?? 'Sửa mật khẩu thất bại.');
      } else {
        print(data.toString());
      }
    }
  }
}
