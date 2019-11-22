import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/widgets/outStockFooter.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/widgets/outStockHeader.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/widgets/outStockList.dart';

class OutOfStockDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.1;
    final footerHeight = screenHeight * 0.17;
    return Drawer(
      child: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            color: Theme.of(context).colorScheme.background,
            child: OutStockList(
              headerHeight: headerHeight,
              footerHeight: footerHeight,
            ),
          ),
          SizedBox(
            height: footerHeight,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: OutStockHeader(
              height: headerHeight,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: OutStockFooter(
              height: footerHeight,
            ),
          )
        ]),
      ),
    );
  }
}
