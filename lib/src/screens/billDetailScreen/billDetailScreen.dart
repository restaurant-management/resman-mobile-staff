import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/widgets/dishList.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/widgets/summaryBill.dart';

import '../../widgets/AppBars/mainAppBar.dart';
import '../../widgets/drawerScaffold.dart';

class BillDetailScreen extends StatefulWidget {
  @override
  _BillDetailScreenState createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen> {
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
      appBar: MainAppBar(),
//      floatingActionButton: SecondaryCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:
      DishList(
            billDetails: FakeData.billDishes,
          ),
      bottomNavigationBar: SizedBox(
          height: 56,
          child: SummaryBill(
            billDetails: FakeData.billDishes,
          )),
    );

  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
