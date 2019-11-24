import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenStaff/tableButton.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenWareManager/stockList.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/cartButton/secondaryCartButton.dart';
import 'package:resman_mobile_staff/src/widgets/dishList/dailyDishesList.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';
import 'package:resman_mobile_staff/src/widgets/importStock/importFab.dart';

import '../../blocs/authenticationBloc/bloc.dart';

class HomeScreenWareManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenWareManagerState();
  }
}

class _HomeScreenWareManagerState extends State<HomeScreenWareManager> {
  AuthenticationBloc authenticationBloc;
  ScrollController scrollController;

  void onPress() {
    print("Button Pressed!");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: MainAppBar(),
      floatingActionButton: ImportFab(),
      body: CustomScrollView(
        controller: scrollController,
        primary: false,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverFillRemaining(
            child: Scrollbar(
              child: StockList(stockList: FakeData.listStock),
            ),
          ),
        ],
      ),
    );
  }
}
