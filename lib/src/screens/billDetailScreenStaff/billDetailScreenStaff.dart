import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenStaff/widgets/dishListStaff.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenStaff/widgets/summaryBill.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/backAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/loadingIndicator.dart';
import 'package:toast/toast.dart';

import '../../widgets/drawerScaffold.dart';

class BillDetailScreenStaff extends StatefulWidget {
  final int billId;

  const BillDetailScreenStaff({Key key, this.billId}) : super(key: key);

  @override
  _BillDetailScreenStaffState createState() => _BillDetailScreenStaffState();
}

class _BillDetailScreenStaffState extends State<BillDetailScreenStaff> {
  RefreshController _refreshController;
  Repository _repository = Repository();
  BillModel bill;
  bool isFetched = false;

  @override
  void initState() {
    super.initState();
    _repository.getBill(widget.billId).then((value) {
      setState(() {
        bill = value;
        isFetched = true;
      });
    }).catchError((e) {
      Toast.show(e, context);
    });
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
      body: isFetched
          ? DishListStaff(
              billDetails: bill.dishes,
            )
          : LoadingIndicator(),
      bottomNavigationBar: SizedBox(
        height: 66,
        child: isFetched
            ? SummaryBill(
                billDetails: bill.dishes,
              )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
