import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/widgets/billBar/billStatusItem.dart';

//import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/bloc.dart';
//import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/event.dart';
//import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/state.dart';
//import 'package:restaurant_management_mobile/src/widgets/dishList/dishesList.dart';
//import 'package:restaurant_management_mobile/src/widgets/loadingIndicator.dart';

import '../../widgets/AppBars/mainAppBar.dart';
import '../../widgets/cartButton/secondaryCartButton.dart';
import '../../widgets/drawerScaffold.dart';
import '../../widgets/dishList/dishesList.dart';

class HomeScreenStaff extends StatefulWidget {
  @override
  _HomeScreenStaffState createState() => _HomeScreenStaffState();
}

class _HomeScreenStaffState extends State<HomeScreenStaff> {
//  final DailyDishBloc _dailyDishBloc = DailyDishBloc();
  RefreshController _refreshController;

  @override
  void initStaDishesTodayScreente() {
    super.initState();
    _refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    //Fake data
    String jsonParsed =
        '{"billHistoryId":1,"note":"Khong bo hanh","preparedAt":"1969-07-20 20:18:04Z","delivaryAt":"1969-07-20 20:18:04Z","quantily":5,"price":10000,"dish":{"dishId":10,"name":"Chao ga","description":"abcsaca","defaultPrice":20000,"images":[]}}';
    String billJson =
        '{"billId":1,"createBy;":{},"preparedBy;":{},"collectBy;":{},"customerId;":{},"tableNumber;":{},"createAt;":{},"prepareAt;":{},"collectAt;":{},"collectValue":10}';

    Map<String, dynamic> dish = jsonDecode(
        '{"day":"1969-07-20 20:18:04Z","session": "morning","storeId": 1,"confirmBy": 1,"confirmAt": "1969-07-20 20:18:04Z","dishes": {"dishId": 1,"name": "Ca kho","description": "acascc","images": ["https://d3h1lg3ksw6i6b.cloudfront.net/media/image/2018/08/24/e46c807ef357438e9d1f7f53682cc2e6_Elements_Hokkaido+Kozatsu+Beef.jpg"]}}');
    DailyDishModel dailyDish = DailyDishModel.fromJson(dish);
    List<DailyDishModel> listDailyDish = [
      dailyDish,
      dailyDish,
      dailyDish,
      dailyDish,
      dailyDish,
      dailyDish
    ];

    BillDishModel billDish = BillDishModel.fromJson(jsonDecode(jsonParsed));
    ;
    BillModel bill = BillModel.fromJson(jsonDecode(billJson));

    return DrawerScaffold(
      appBar: MainAppBar(),
      floatingActionButton: SecondaryCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: <Widget>[
        Column(children: <Widget>[
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    BillStatusItem(
                      bill: bill,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BillStatusItem(
                      bill: bill,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BillStatusItem(
                      bill: bill,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 3,
            child: ListView(
              children: <Widget>[
                DishesList(listDailyDish: listDailyDish),
              ],
            ),
          ),
        ]),
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
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
