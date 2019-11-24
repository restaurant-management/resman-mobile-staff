import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenWareManager/stockList.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';
import 'package:resman_mobile_staff/src/widgets/importStock/importFab.dart';

class HomeScreenWareManager extends StatefulWidget {
  @override
  _HomeScreenWareManagerState createState() => _HomeScreenWareManagerState();
}

class _HomeScreenWareManagerState extends State<HomeScreenWareManager> {
  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: MainAppBar(),
      floatingActionButton: ImportFab(),
      body: StockList(
        stockList: FakeData.listStock,
        headerContent: 'Số hàng còn lại trong kho',
        headerHeight: 30,
      ),
    );
  }
}
