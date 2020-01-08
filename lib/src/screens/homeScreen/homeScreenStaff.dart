import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/shortBill.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:resman_mobile_staff/src/repositories/socketProvider/staffSocket.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenStaff/billDetailScreenStaff.dart';
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Repository _repository = Repository();
  AuthenticationBloc authenticationBloc;
  ScrollController scrollController;
  StaffSocket _socket = new StaffSocket();
  List<ShortBill> _listBillInShort;

  List<BillDishModel> currentBill;

  bool isConnectSocket = false;
  bool isFetched = false;
  bool isFail = false;
  int notificationCounter = 0;

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
      notificationCounter++;
      ShortBill _updatedBill = ShortBill.fromJson(data);
      setState(() {
        ShortBill _editBill = _listBillInShort.firstWhere(
            (e) => e.billId == _updatedBill.billId,
            orElse: () => null);
        if (_editBill != null) {
          _showNotificationWithSound(
              notificationCounter,
              _updatedBill,'Món hoàn tất',
              'Có món mới hoàn thành ở bàn ${_updatedBill.tableNumber}');
          int index = _listBillInShort.indexOf(_editBill);
          _listBillInShort[index] = _updatedBill;
        } else {
          _showNotificationWithSound(
              notificationCounter,
              _updatedBill,
              'Hóa đơn mới',
              'Có hóa đơn mới ở bàn ${_updatedBill.tableNumber}');
          _listBillInShort.add(_updatedBill);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    /// Init local notification
    var initializationSettingAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingAndroid, initializationSettingIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

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

  Future<dynamic> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
//      Navigator.of(context).popUntil((route) => route.);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BillDetailScreenStaff(billId: int.parse(payload)),
        ),
      );
    }
    return;
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

  /// Notification method
  // Method 1
  Future _showNotificationWithSound(
      int id, ShortBill bill, String title, String message) async {
    var vibrationPattern = new Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      '1',
      'Resman',
      'Phần mềm quản lý nhà hàng',
      sound: 'slow_spring_board',
      importance: Importance.Max,
      priority: Priority.High,
      enableLights: true,
      enableVibration: true,
      vibrationPattern: vibrationPattern,
    );
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      message,
      platformChannelSpecifics,
      payload: '${bill.billId}',
    );
  }

// Method 2
  Future _showNotificationWithDefaultSound(int id, ShortBill bill) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'Resman', 'Phần mềm quản lý nhà hàng',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      id,
      'Hóa đơn mới',
      'Có hóa đơn mới ở bàn ${bill.tableNumber}',
      platformChannelSpecifics,
      payload: '${bill.billId}',
    );
  }

// Method 3
  Future _showNotificationWithoutSound(int id, ShortBill bill) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'Resman', 'Phần mềm quản lý nhà hàng',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      id,
      'Hóa đơn mới',
      'Có hóa đơn mới ở bàn ${bill.tableNumber}',
      platformChannelSpecifics,
      payload: '${bill.billId}',
    );
  }
}
