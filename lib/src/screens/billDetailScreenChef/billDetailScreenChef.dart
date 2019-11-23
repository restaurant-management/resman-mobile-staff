import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenChef/widgets/dishListChef.dart';

import '../../widgets/AppBars/mainAppBar.dart';
import '../../widgets/drawerScaffold.dart';

class BillDetailScreenChef extends StatefulWidget {
  @override
  _BillDetailScreenChefState createState() => _BillDetailScreenChefState();
}

class _BillDetailScreenChefState extends State<BillDetailScreenChef> {
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
      DishListChef(
            billDetails: FakeData.billDishes,
          ),
//      bottomNavigationBar: SizedBox(
//          height: 56,
//          child: SummaryBill(
//            billDetails: FakeData.billDishes,
//          )),
    );

  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
