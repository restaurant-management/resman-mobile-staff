import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';
import 'package:resman_mobile_staff/src/widgets/cartButton/primaryCartButton.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isShowAction;
  final PreferredSizeWidget bottom;
  final String tittle;

  MainAppBar({Key key, this.bottom, this.tittle, this.isShowAction = true})
      : preferredSize =
            Size.fromHeight(56.0 + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return AppBar(
      bottom: widget.bottom,
      elevation: 5,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: GradientColor.of(context).primaryLinearGradient),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: colors.colorScheme.onPrimary,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Hero(
        tag: 'HeroLogoImage',
        child: _titleMaker(widget.tittle),
      ),
      actions: widget.isShowAction
          ? <Widget>[PrimaryCartButton()]
          : <Widget>[Container()],
    );
  }

  Widget _titleMaker(tittle) {
    if (tittle != null) {
      return Text(
        tittle,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 40,
            fontFamily: 'Rukola'),
      );
    } else {
      return Text(
        "Resman",
        style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 40,
            fontFamily: 'Rukola'),
      );
    }
  }
}
