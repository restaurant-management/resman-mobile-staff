import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';
import 'package:resman_mobile_staff/src/screens/cartScreen/cartDrawer.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenStaff/tableButton.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/cartButton/secondaryCartButton.dart';
import 'package:resman_mobile_staff/src/widgets/dishList/dailyDishesList.dart';
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

  bool isFetched = false;
  bool isFail = false;

  void onPress() {
    print("Button Pressed!");
  }

  @override
  void initState() {
    super.initState();
    _repository
        .fetchDailyDishes()
        .then((_) => setState(() => this.isFetched = true));
//        .catchError((Exception ex) {
//      setState(() => this.isFail = true);
//      });
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
          headerSliverBuilder: (_, __) =>
          [
            SliverAppBar(
              leading: Container(),
              pinned: false,
              floating: false,
              snap: false,
//            title: Center(child: Text('Danh sách hóa đơn')),
              actions: <Widget>[Container()],
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
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
                        badgeNumber: FakeData.bill.collectValue,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TableButton(
                        isDone: true,
                        tableNumber: 20,
                        badgeNumber: FakeData.bill.collectValue,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TableButton(
                        isDone: false,
                        tableNumber: 3,
                        badgeNumber: FakeData.bill.collectValue,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TableButton(
                        isDone: false,
                        tableNumber: 4,
                        badgeNumber: FakeData.bill.collectValue,
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
                      return DailyDishesList(listDailyDish: dailyDishes);
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
