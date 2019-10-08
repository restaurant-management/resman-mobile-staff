import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resman_mobile_staff/src/models/dailyDish.dart';
//import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/bloc.dart';
//import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/event.dart';
//import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/state.dart';
//import 'package:restaurant_management_mobile/src/widgets/dishList/dishesList.dart';
//import 'package:restaurant_management_mobile/src/widgets/loadingIndicator.dart';

import '../../widgets/AppBars/mainAppBar.dart';
import '../../widgets/cartButton/secondaryCartButton.dart';
import '../../widgets/drawerScaffold.dart';
import '../../widgets/dishList/dishesList.dart';

class DishesTodayScreen extends StatefulWidget {


  @override
  _DishesTodayScreenState createState() => _DishesTodayScreenState();
}

class _DishesTodayScreenState extends State<DishesTodayScreen> {
//  final DailyDishBloc _dailyDishBloc = DailyDishBloc();
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    //Fake data
    Map<String, dynamic> dish = jsonDecode('{"day":"1969-07-20 20:18:04Z","session": "morning","storeId": 1,"confirmBy": 1,"confirmAt": "1969-07-20 20:18:04Z","dishes": {"dishId": 1,"name": "Ca kho","description": "acascc","images": ["https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2018/08/24/e46c807ef357438e9d1f7f53682cc2e6_Elements_Hokkaido+Kozatsu+Beef.jpg"]}}');
    DailyDish dailyDish = DailyDish.fromJson(dish);
    List<DailyDish> listDailyDish = [dailyDish, dailyDish, dailyDish, dailyDish, dailyDish, dailyDish];

    return DrawerScaffold(
      appBar: MainAppBar(),
      floatingActionButton: SecondaryCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: <Widget>[
      DishesList(listDailyDish: listDailyDish),
        Align(
          heightFactor: 60,
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: <Color>[
                    const Color.fromRGBO(88, 39, 176, 0.7),
                    const Color.fromRGBO(88, 39, 176, 0.3),
                    const Color.fromRGBO(88, 39, 176, 0.0),
                  ],
                  stops: [0.1, 0.7, 1.0],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
            height: 60.0,
          ),

        )
      ]),
    );
  }

  @override
  void dispose(){
    _refreshController.dispose();
    super.dispose();
  }
}
