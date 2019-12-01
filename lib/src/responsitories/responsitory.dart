import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:resman_mobile_staff/src/common/EnvVariables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userModel.dart';
import '../utils/validateEmail.dart';
import 'dataProviders/userProvider.dart';

class Repository {
  static Repository _singleton;

  static Repository get instance {
    if (_singleton == null) {
      print('Initialize Repository ...');
      _singleton = Repository._internal();
    }
    return _singleton;
  }

  factory Repository() {
    return instance;
  }

  Repository._internal();

  final UserProvider _userProvider = UserProvider();

  UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  Future<String> authenticate(
      {@required String usernameOrEmail, @required String password}) async {
    return await _userProvider.login(usernameOrEmail, password);
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(EnvVariables.PrepsTokenKey); // Delete token
    await prefs.remove(EnvVariables.PrepsUsernameOrEmail); // Delete username or email
    _currentUser = null;
    return;
  }

  Future<void> persistToken(String token, String usernameOrEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(EnvVariables.PrepsTokenKey, token); // Save token
    await prefs.setString(
        EnvVariables.PrepsUsernameOrEmail, usernameOrEmail); // Save username or email
    return;
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EnvVariables.PrepsTokenKey) != null;
  }

  Future<void> register(String username, String email, String password) async {
    await _userProvider.register(username, email, password);
  }

  Future<void> fetchCurrentUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameOrEmail = prefs.getString(EnvVariables.PrepsUsernameOrEmail);
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    if (validateEmail(usernameOrEmail)) {
      _currentUser =
      await _userProvider.getProfileByEmail(usernameOrEmail, token);
    } else {
      _currentUser =
      await _userProvider.getProfileByUsername(usernameOrEmail, token);
    }
    print(_currentUser);
  }
}
