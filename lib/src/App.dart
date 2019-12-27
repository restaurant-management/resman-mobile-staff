import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'screens/splashScreen/splashScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff6CABDD),
          accentColor: Colors.cyan[600],
          hintColor: Colors.white,
          colorScheme: ColorScheme(
            primary: Color(0xff6CABDD),
            primaryVariant: Color(0xff7979E2),
            brightness: Brightness.light,
            error: Colors.red,
            onBackground: Colors.black,
            onError: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Color(0xff4F4F4F),
            secondary: Color(0xffFFDC74),
            secondaryVariant: Color(0xffFFC374),
            surface: Color(0xffF2F2F2),
            background: Colors.white,
          ),
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
              body1: TextStyle(color: Colors.black),
              headline: TextStyle(color: Colors.black))),
      home: SplashScreen(),
    );
  }
}
