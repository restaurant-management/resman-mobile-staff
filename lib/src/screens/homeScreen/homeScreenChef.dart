import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenChef/billDetailScreenChef.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenChef/billListItem.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/outOfStockDrawer.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/customAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/customTabIndicator.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';

import '../../blocs/authenticationBloc/bloc.dart';

class HomeScreenChef extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenChefState();
  }
}

class _HomeScreenChefState extends State<HomeScreenChef>
    with SingleTickerProviderStateMixin {
  AuthenticationBloc authenticationBloc;
  ScrollController scrollController;
  final tabList = ['Hóa đơn', 'Đang chuẩn bị'];
  TabController _tabController;
  List<BillModel> unStageBill = new List<BillModel>();
  List<BillModel> stageBill = new List<BillModel>();

  void onpress() {
    print("Button Pressed!");
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
    _tabController = TabController(vsync: this, length: tabList.length);
    unStageBill.add(FakeData.bill);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DrawerScaffold(
      endDrawer: OutOfStockDrawer(),
      appBar: MainAppBar(
        bottom: CustomTabBar(
          controller: _tabController,
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colorScheme.onSecondary,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                bottom: BorderSide(
                  color: colorScheme.onSecondary,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
              color: colorScheme.onPrimary),
          labelColor: colorScheme.onBackground,
          indicator: PointTabIndicator(
              color: colorScheme.primary, insets: EdgeInsets.only(bottom: 4)),
          labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 15),
          tabs: tabList.map((item) {
            return CustomTab(
              text: item,
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 5,
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: unStageBill.length,
            itemBuilder: (BuildContext context, int index) {
              return BillListItem(
                bill: unStageBill[index],
                count: 10,
                onPressed: () =>
                    setState(() => stageBill.add(unStageBill[index])),
                icon: Icons.email,
              );
            },
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 5,
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: stageBill.length,
            itemBuilder: (BuildContext context, int index) {
              return BillListItem(
                bill: stageBill[index],
                count: 10,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => BillDetailScreenChef(),
                    ),
                  );
                },
                icon: Icons.email,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
