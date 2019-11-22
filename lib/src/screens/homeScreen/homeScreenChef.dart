import 'package:flutter/cupertino.dart';
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
  ScrollController scrollController;

  void onpress() {
    print("Button Pressed!");
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: MainAppBar(),
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            floating: true,
            pinned: true,
            snap: true,
            leading: Container(),
            actions: <Widget>[Container()],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: _buildList(),
            ),
          ),
          SliverFillRemaining(
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
                  onPressed: this.onpress,
                  icon: Icons.email,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    Widget listWidget = ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        CupertinoButton(
          child: BillStatusItem(
            content: 'Hoa don dang chuan bi',
            number: FakeData.bill.collectValue,
          ),
          onPressed: () {},
        ),
        SizedBox(
          height: 10,
        ),
        CupertinoButton(
          child: BillStatusItem(
            content: 'Hoa don chuan bi xong',
            number: FakeData.bill.collectValue,
          ),
          onPressed: () {},
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );

    double scale = 1;
    if (scrollController.hasClients) {
      if (scrollController.offset != 0) scale = 1;
      if (scale < 0) {
        scale = 0;
      }
    } else {
      scale = 1;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: listWidget,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
