import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/widgets/AppBars/mainAppBar.dart';
import 'package:resman_mobile_staff/src/widgets/billBar/billListItem.dart';
import 'package:resman_mobile_staff/src/widgets/billBar/billStatusItem.dart';
import 'package:resman_mobile_staff/src/widgets/drawerScaffold.dart';

import '../../blocs/authenticationBloc/bloc.dart';

class HomeScreenChef extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenChefState();
  }
}

class _HomeScreenChefState extends State<HomeScreenChef> {
  AuthenticationBloc authenticationBloc;

  void onpress() {
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        child: BillStatusItem(
                          content: 'Hoa don da chuan bi',
                          number: FakeData.bill.collectValue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BillStatusItem(
                        content: 'Hoa don chuan bi xong',
                        number: FakeData.bill.collectValue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 4,
                child: Scrollbar(
                    child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return BillListItem(
                      billDish: FakeData.billDish,
                      count: 10,
                      onpressed: this.onpress,
                      icon: Icons.email,
                    );
                  },
                ))),
          ],
        ));
  }
}
