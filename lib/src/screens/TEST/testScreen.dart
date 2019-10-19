import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/billBar/billListItem.dart';
import 'package:resman_mobile_staff/src/widgets/billBar/billStatusItem.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';

import '../../blocs/authenticationBloc/bloc.dart';
import '../../blocs/authenticationBloc/event.dart';
import '../../blocs/authenticationBloc/state.dart';
import '../../widgets/animationLogo.dart';
import '../dishesTodayScreen/dishesTodayScreen.dart';
import '../loginScreen/loginScreen.dart';

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestScreenState();
  }
}

class _TestScreenState extends State<TestScreen> {
  String jsonParsed =
      '{"billHistoryId":1,"note":"Khong bo hanh","preparedAt":"1969-07-20 20:18:04Z","delivaryAt":"1969-07-20 20:18:04Z","quantily":5,"price":10000,"dish":{"dishId":10,"name":"Chao ga","description":"abcsaca","defaultPrice":20000,"images":[]}}';
  String billJson =
      '{"billId":1,"createBy;":{},"preparedBy;":{},"collectBy;":{},"customerId;":{},"tableNumber;":{},"createAt;":{},"prepareAt;":{},"collectAt;":{},"collectValue":10}';
  AuthenticationBloc authenticationBloc;

  BillDishModel billDish;
  BillModel bill;

  void onpress() {
    print("Button Pressed!");
  }

  @override
  void initState() {
    super.initState();
    billDish = BillDishModel.fromJson(jsonDecode(jsonParsed));
    bill = BillModel.fromJson(jsonDecode(billJson));
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
        appBar: MainAppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 400.0,
                child: new ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.white,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return BillListItem(
                      billDish: billDish,
                      count: 10,
                      onpressed: this.onpress,
                      icon: Icons.email,
                    );
                  },
                ),
              ),
            ),
            // Expanded(
            //   child: SizedBox(
            //     height: 400.0,
            //     child: new ListView.builder(
            //       scrollDirection: Axis.vertical,
            //       itemCount: 3,
            //       // separatorBuilder: (BuildContext context, int index) => Divider(
            //       //     color: Colors.white,
            //       // ),
            //       itemBuilder: (BuildContext context, int index) {
            //         return BillStatusItem(
            //           bill: bill,
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  }
}
