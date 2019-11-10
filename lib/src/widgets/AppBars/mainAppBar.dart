import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({Key key})
      : preferredSize = Size.fromHeight(56.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 5,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: primaryColor,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Hero(
        tag: 'HeroLogoImage',
        child: Text(
          'Năm Nhỏ',
          style: TextStyle(
              color: primaryColor, fontSize: 40, fontFamily: 'Rukola'),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.people,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        )
      ],
    );
  }
}
