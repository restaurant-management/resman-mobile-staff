import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/outOfStockDrawer.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';
import 'package:resman_mobile_staff/src/widgets/dishList/dishesList.dart';

import '../../widgets/AppBars/mainAppBar.dart';
import '../../widgets/cartButton/secondaryCartButton.dart';
import '../../widgets/drawerScaffold.dart';

class PreparedBillScreen extends StatefulWidget {
  @override
  _PreparedBillScreenState createState() => _PreparedBillScreenState();
}

class _PreparedBillScreenState extends State<PreparedBillScreen> {
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

    return DrawerScaffold(
      endDrawer: OutOfStockDrawer(),
      appBar: MainAppBar(),
      floatingActionButton: SecondaryCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: <Widget>[
        Column(children: <Widget>[
          Expanded(
            flex: 3,
            child: ListView(
              children: <Widget>[
                DishesList(listDailyDish: FakeData.listDailyDish),
              ],
            ),
          ),
        ]),
        Align(
          heightFactor: 60,
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: new BoxDecoration(
              gradient: GradientColor.of(context).drawerHeader,
            ),
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
