import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/screens/TEST/testScreen.dart';
import 'package:resman_mobile_staff/src/screens/dishesTodayScreen/dishesTodayScreen.dart';
import 'package:resman_mobile_staff/src/screens/editProfileScreen/editPasswordScreen.dart';
import 'package:resman_mobile_staff/src/screens/editProfileScreen/editProfileScreen.dart';
import 'package:resman_mobile_staff/src/screens/profileScreen/profileScreen.dart';

import 'models/userModel.dart';
import 'screens/splashScreen/splashScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userJson = jsonDecode(
        '{"userId": 1,"uuid": "1","userName": "ThanhDuy","fullName": "Phan Thanh Duy","email": "abc@mail.com","password": "","avatar": "https://avatars0.githubusercontent.com/u/36978155?s=460&v=4","birthday": "1969-07-20 20:18:04Z","phoneNumber": "120382103821098","address": "abc","roles":[]}');
    UserModel user = UserModel.fromJson(userJson);

    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff9c27b0),
          accentColor: Colors.cyan[600],
          hintColor: Colors.white,
          colorScheme: ColorScheme(
            primary: Color(0xff9c27b0),
            primaryVariant: Color(0xff641971),
            brightness: Brightness.light,
            error: Colors.red,
            onBackground: Colors.black,
            onError: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            secondary: Color(0xff273bb0),
            secondaryVariant: Color(0xff5827b0),
            surface: Colors.black,
            background: Colors.grey[100],
          ),
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
              body1: TextStyle(color: Colors.black),
              headline: TextStyle(color: Colors.black))),
      home: SplashScreen(),
    );
  }
}
