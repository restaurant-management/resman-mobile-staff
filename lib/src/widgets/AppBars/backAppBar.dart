import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../cartButton/primaryCartButton.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showShoppingCart;
  final List<Widget> right;
  final Widget bottom;

  BackAppBar({Key key, this.showShoppingCart = true, this.right, this.bottom})
      : preferredSize = Size.fromHeight(56.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    List<Widget> actions = [];
    if (showShoppingCart) actions.add(PrimaryCartButton());
    if (right != null) actions.addAll(right);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      centerTitle: true,
      bottom: bottom,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: primaryColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Năm Nhỏ',
        style:
            TextStyle(color: primaryColor, fontSize: 40, fontFamily: 'Rukola'),
      ),
      actions: actions,
    );
  }
}
