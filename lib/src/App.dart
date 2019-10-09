import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/dailyDish.dart';
import 'package:resman_mobile_staff/src/screens/dishesTodayScreen/dishesTodayScreen.dart';
import 'package:resman_mobile_staff/src/screens/editProfileScreen/editProfileScreen.dart';
import 'package:resman_mobile_staff/src/screens/profileScreen/profileScreen.dart';

import 'screens/splashScreen/splashScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              headline:
              TextStyle(color: Colors.black))),
      home: ProfileScreen(),
    );
  }
}
