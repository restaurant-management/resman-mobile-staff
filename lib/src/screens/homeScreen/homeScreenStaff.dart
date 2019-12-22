import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:resman_mobile_staff/src/screens/cartScreen/cartDrawer.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenStaff/tableButton.dart';
import 'package:resman_mobile_staff/src/screens/loginScreen/loginScreen.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/cartButton/secondaryCartButton.dart';
import 'package:resman_mobile_staff/src/widgets/dishList/dishesList.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';
import 'package:resman_mobile_staff/src/widgets/loadingIndicator.dart';

import '../../blocs/authenticationBloc/bloc.dart';

class HomeScreenStaff extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenStaffState();
  }
}

class _HomeScreenStaffState extends State<HomeScreenStaff> {
  Repository _repository = Repository();
  AuthenticationBloc authenticationBloc;
  ScrollController scrollController;

  List<BillDishModel> currentBill;

  bool isFetched = false;
  bool isFail = false;

  void onPress() {
    print("Button Pressed!");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    authenticationBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentBill = new List<BillDishModel>();
    _repository
        .fetchDailyDishes()
        .then((_) => setState(() => this.isFetched = true))
        .catchError((e) {
      setState(() => this.isFail = true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);

    if (isFetched) {
      List<DailyDishModel> dailyDishes = _repository.dailyDish;
      return DrawerScaffold(
        endDrawer: CartDrawer(),
        appBar: MainAppBar(),
        floatingActionButton: SecondaryCartButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            SliverAppBar(
              leading: Container(),
              pinned: false,
              floating: false,
              snap: false,
//            title: Center(child: Text('Danh sách hóa đơn')),
              actions: <Widget>[Container()],
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 62, right: 62),
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                    color: colors.colorScheme.surface,
                  ),
                ),
                title: Container(
                  margin: const EdgeInsets.only(top: 70.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      TableButton(
                        isDone: false,
                        tableNumber: 1,
                        badgeNumber: 10,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TableButton(
                        isDone: true,
                        tableNumber: 20,
                        badgeNumber: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TableButton(
                        isDone: false,
                        tableNumber: 3,
                        badgeNumber: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TableButton(
                        isDone: false,
                        tableNumber: 4,
                        badgeNumber: 0,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
          body: CustomScrollView(
            controller: scrollController,
            primary: false,
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverFillRemaining(
                child: Scrollbar(
                  child: ListView.separated(
                    primary: true,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5,
                      );
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return DishesList(listDailyDish: dailyDishes);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return LoadingIndicator();
  }
}
