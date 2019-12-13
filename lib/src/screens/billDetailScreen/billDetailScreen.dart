import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/widgets/dishList.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/widgets/summaryBill.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/backAppBar.dart';

import '../../widgets/AppBars/mainAppBar.dart';
import '../../widgets/drawerScaffold.dart';

class BillDetailScreen extends StatefulWidget {
  final BillModel bill;

  const BillDetailScreen({Key key, this.bill}) : super(key: key);
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
      appBar: BackAppBar(tittle: "Thông tin hóa đơn",),
//      floatingActionButton: SecondaryCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:
      DishList(
            billDetails: FakeData.billDishes,
          ),
      bottomNavigationBar: SizedBox(
          height: 61,
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
