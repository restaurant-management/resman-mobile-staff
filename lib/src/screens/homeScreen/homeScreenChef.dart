import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:resman_mobile_staff/src/repositories/socketProvider/chefSocket.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenChef/billDetailScreenChef.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenChef/billListItem.dart';
import 'package:resman_mobile_staff/src/screens/loginScreen/loginScreen.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/outOfStockDrawer.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/customAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/customTabIndicator.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';
import 'package:resman_mobile_staff/src/widgets/loadingIndicator.dart';
import 'package:toast/toast.dart';

import '../../blocs/authenticationBloc/bloc.dart';

class HomeScreenChef extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenChefState();
  }
}

class _HomeScreenChefState extends State<HomeScreenChef>
    with SingleTickerProviderStateMixin {
  AuthenticationBloc authenticationBloc = new AuthenticationBloc();
  ScrollController scrollController;
  bool isFetched = false;
  bool isFail = false;
  final tabList = ['Hóa đơn', 'Đang chuẩn bị'];
  TabController _tabController;
  List<BillModel> unStageBill = new List<BillModel>();
  List<BillModel> stageBill = new List<BillModel>();
  Repository _repository = new Repository();
  ChefSocket _socket = new ChefSocket();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var unStageBillKey = GlobalKey<AnimatedListState>();
  var stageBillKey = GlobalKey<AnimatedListState>();

  void onpress() {
    print("Button Pressed!");
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    _tabController = TabController(vsync: this, length: tabList.length);

    _repository.getAllBillChef().then((List<BillModel> value) {
      value.forEach((BillModel item) {
        if (item.prepareAt != null)
          stageBill.insert(0, item);
        else
          unStageBill.insert(0, item);
      });

      setState(() {});
      setState(() => this.isFetched = true);
    }).catchError((e) {
      setState(() => this.isFail = true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(
            authenticationBloc: authenticationBloc,
          ),
        ),
      );
    });

    Future.delayed(Duration(seconds: 5)).then((_) {
      /// Run after build completely
      _connectSocket();
    });
  }

  void _connectSocket() async {
    await _socket.InitConnect();

    _socket.socket.on('new_bill', (data) {
      setState(() {
        unStageBill.insert(0, BillModel.fromJson(data));
        unStageBillKey.currentState.insertItem(0);
        showMessage('Có hóa đơn mới!');
        scrollController.animateTo(0,
            duration: Duration(milliseconds: 1000), curve: Curves.bounceIn);
      });
    });

    _socket.socket.on('new_prepare_d_bill', (data) {
      setState(() {
        unStageBill.insert(0, BillModel.fromJson(data));
        unStageBillKey.currentState.insertItem(0);
        showMessage('Có hóa đơn mới!');
        scrollController.animateTo(0,
            duration: Duration(milliseconds: 1000), curve: Curves.bounceIn);
      });
    });
  }

  void showMessage(String msg) {
    Toast.show(msg, context);
//    scaffoldKey.currentState.showSnackBar(
//      SnackBar(
//        content: Text(msg),
//        backgroundColor: Theme.of(context).accentColor,
//      ),
//    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    _socket.socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DrawerScaffold(
      key: scaffoldKey,
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
          isFetched
              ? AnimatedList(
                  controller: scrollController,
                  reverse: false,
                  initialItemCount: unStageBill.length,
                  key: unStageBillKey,
                  itemBuilder: (BuildContext context, int index, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: BillListItem(
                        bill: unStageBill[index],
                        count: unStageBill[index].dishes?.length ?? 0,
                        onPressed: () {
                          setState(() => stageBill.add(unStageBill[index]));
                          _repository
                              .prepareBill(unStageBill[index].id)
                              .then((_) {})
                              .catchError((e) {
                            Toast.show(e.toString(), context);
                          });
                          _socket.socket.emit(
                              'new_prepare_bill', 'unStageBill[index].id');
                          setState(
                              () => unStageBill.remove(unStageBill[index]));
                        },
                        icon: Icons.email,
                      ),
                    );
                  },

//                  separatorBuilder: (BuildContext context, int index) {
//                    return SizedBox(
//                      height: 5,
//                    );
//                  },
//                  scrollDirection: Axis.vertical,
//                  itemCount: unStageBill.length,
//                  itemBuilder: (BuildContext context, int index) {
//                    return BillListItem(
//                      bill: unStageBill[index],
//                      count: 10,
//                      onPressed: () {
//                        setState(() => stageBill.add(unStageBill[index]));
//                        _repository.prepareBill(unStageBill[index].id);
//                        _socket.socket
//                            .emit('new_prepare_bill', 'unStageBill[index].id');
//                        setState(() => unStageBill.remove(unStageBill[index]));
//                      },
//                      icon: Icons.email,
//                    );
//                  },
                )
              : LoadingIndicator(),
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
                btnText: 'Chi tiết',
                bill: stageBill[index],
                count: 10,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => BillDetailScreenChef(
                        billId: stageBill[index].id,
                      ),
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
}
