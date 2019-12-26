import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenStaff/widgets/dishListStaff.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenStaff/widgets/summaryBill.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/backAppBar.dart';

import '../../widgets/drawerScaffold.dart';

class BillDetailScreenStaff extends StatefulWidget {
  @override
  _BillDetailScreenStaffState createState() => _BillDetailScreenStaffState();
}

class _BillDetailScreenStaffState extends State<BillDetailScreenStaff> {
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
      appBar: BackAppBar(
        showShoppingCart: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: DishListStaff(
        billDetails: FakeData.billDishes,
      ),
      bottomNavigationBar: SizedBox(
        height: 66,
        child: SummaryBill(
          billDetails: FakeData.billDishes,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
