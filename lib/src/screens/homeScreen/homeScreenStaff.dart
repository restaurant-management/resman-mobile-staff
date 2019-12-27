import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/shortBill.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:resman_mobile_staff/src/repositories/socketProvider/staffSocket.dart';
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
  StaffSocket _socket = new StaffSocket();
  List<ShortBill> _listBillInShort;

  List<BillDishModel> currentBill;

  bool isConnectSocket = false;
  bool isFetched = false;
  bool isFail = false;

  void onPress() {
    print("Button Pressed!");
  }

  @override
  void dispose() {
    authenticationBloc.close();
    _socket.socket.close();
    super.dispose();
  }

  void _connectSocket() async {
    await _socket.InitConnect();

    _socket.socket.on('first_connect', (data) {
      var listBill = data as List ?? [];
      _listBillInShort = listBill.isNotEmpty
          ? listBill.map((i) => ShortBill.fromJson(i)).toList()
          : [];

      setState(() {
        isConnectSocket = true;
      });
    });

    _socket.socket.on('amount_prepared_bill_dish_change', (data) {
      ShortBill _updatedBill = ShortBill.fromJson(data);

      ShortBill _editBill = _listBillInShort.firstWhere(
          (e) => e.billId == _updatedBill.billId,
          orElse: () => null);

//      _listBillInShort = listBill.isNotEmpty
//          ? listBill.map((i) => ShortBill.fromJson(i)).toList()
//          : [];
    });
  }

  @override
  void initState() {
    super.initState();
    currentBill = new List<BillDishModel>();
    _connectSocket();
    _repository
        .fetchDailyDishes()
        .then((_) => setState(() => this.isFetched = true))
        .catchError((e) {
      setState(() => this.isFail = true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(
            authenticationBloc: this.authenticationBloc,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    List<DailyDishModel> dailyDishes = _repository.dailyDish;
    return DrawerScaffold(
      endDrawer: CartDrawer(),
      appBar: MainAppBar(),
      floatingActionButton: SecondaryCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: isFetched
          ? NestedScrollView(
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
                      child: isConnectSocket
                          ? ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _listBillInShort.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 5,
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return TableButton(
                                  billId: _listBillInShort[index].billId,
                                  status: _listBillInShort[index].status,
                                  tableNumber:
                                      _listBillInShort[index].tableNumber,
                                  badgeNumber: _listBillInShort[index]
                                          .amountPreparedDishes ??
                                      0,
                                );
                              },
                            )
                          : LoadingIndicator(),
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
            )
          : LoadingIndicator(),
    );
  }
}
