import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/billDetailScreen.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/billBar/billStatusItem.dart';
import 'package:resman_mobile_staff/src/widgets/dishList/dailyDishesList.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';

import '../../blocs/authenticationBloc/bloc.dart';

class HomeScreenStaff extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenStaffState();
  }
}

class _HomeScreenStaffState extends State<HomeScreenStaff> {
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
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            leading: Container(),
            pinned: true,
            floating: false,
            snap: false,
            title: Center(child: Text('Danh sách hóa đơn')),
            actions: <Widget>[Container()],
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                margin: const EdgeInsets.only(top: 70.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    CupertinoButton(
                      child: BillStatusItem(
                        content: 'Ban 1',
                        number: FakeData.bill.collectValue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillDetailScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CupertinoButton(
                      child: BillStatusItem(
                        content: 'Ban 2',
                        number: FakeData.bill.collectValue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillDetailScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CupertinoButton(
                      child: BillStatusItem(
                        content: 'Ban 3',
                        number: FakeData.bill.collectValue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillDetailScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CupertinoButton(
                      child: BillStatusItem(
                        content: 'Ban 4',
                        number: FakeData.bill.collectValue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillDetailScreen(),
                          ),
                        );
                      },
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
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return DailyDishesList(
                        listDailyDish: FakeData.listDailyDish);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
