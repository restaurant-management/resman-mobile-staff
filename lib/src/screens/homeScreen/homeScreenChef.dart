import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/cartButton/secondaryCartButton.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/widgets/billBar/billListItem.dart';
import 'package:resman_mobile_staff/src/widgets/billBar/billStatusItem.dart';

import '../../blocs/authenticationBloc/bloc.dart';
import '../../blocs/authenticationBloc/event.dart';
import '../../blocs/authenticationBloc/state.dart';
import '../../widgets/animationLogo.dart';
import '../dishesTodayScreen/dishesTodayScreen.dart';
import '../loginScreen/loginScreen.dart';

class HomeScreenChef extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenChefState();
  }
}

class _HomeScreenChefState extends State<HomeScreenChef> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                flex: 4,
                child: Scrollbar(
                    child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return BillListItem(
                      billDish: billDish,
                      count: 10,
                      onpressed: this.onpress,
                      icon: Icons.email,
                    );
                  },
                ))),
          ],
        ));
  }
}
