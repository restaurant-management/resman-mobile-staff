import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/blocs/authenticationBloc/bloc.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:resman_mobile_staff/src/screens/loginScreen/loginScreen.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/widgets/outStockHeader.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/widgets/outStockList.dart';
import 'package:resman_mobile_staff/src/widgets/loadingIndicator.dart';

class OutOfStockDrawer extends StatefulWidget {
  @override
  _OutOfStockDrawerState createState() => _OutOfStockDrawerState();
}

class _OutOfStockDrawerState extends State<OutOfStockDrawer> {
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  Repository _repository = Repository();
  bool isFetched = false;

  @override
  void initState() {
    super.initState();
    _repository
        .fetchDailyDishes()
        .then((_) => setState(() => this.isFetched = true))
        .catchError((e) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(
            authenticationBloc: this.authenticationBloc,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.1;
    final footerHeight = screenHeight * 0.17;
    return Drawer(
      child: isFetched
          ? SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).colorScheme.background,
                    child: OutStockList(
                      dailyDish: _repository.dailyDish,
                      headerHeight: headerHeight,
                      footerHeight: footerHeight,
                    ),
                  ),
                  SizedBox(
                    height: footerHeight,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: OutStockHeader(
                      height: headerHeight,
                    ),
                  ),
                ],
              ),
            )
          : LoadingIndicator(),
    );
  }
}
