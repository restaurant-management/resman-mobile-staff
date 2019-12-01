import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/cartFooter.dart';
import 'widget/cartHeader.dart';
import 'widget/cartList.dart';

class CartDrawer extends StatelessWidget {
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
            child: CartList(
              headerHeight: headerHeight,
              footerHeight: footerHeight,
            ),
          ),
          SizedBox(
            height: footerHeight,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CartHeader(
              height: headerHeight,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CartFooter(
              height: footerHeight,
            ),
          )
        ]),
      ),
    );
  }
}
