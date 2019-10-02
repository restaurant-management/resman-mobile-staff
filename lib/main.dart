import 'package:flutter/material.dart';
import 'package:resman_mobile_customer/src/blocs/authenticationBloc/bloc.dart';
import 'package:resman_mobile_customer/src/screens/loginScreen/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(authenticationBloc: _authenticationBloc),
    );
  }
}
