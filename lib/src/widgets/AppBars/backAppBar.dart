import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';

import '../cartButton/primaryCartButton.dart';

class BackAppBar extends StatefulWidget implements PreferredSizeWidget {
  final tittle;
  final bool showShoppingCart;
  final List<Widget> right;
  final Widget bottom;

  BackAppBar(
      {Key key,
      this.showShoppingCart = true,
      this.right,
      this.bottom,
      this.tittle})
      : preferredSize = Size.fromHeight(56.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _BackAppBarState createState() => _BackAppBarState();
}

class _BackAppBarState extends State<BackAppBar> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final colors = Theme.of(context);

    List<Widget> actions = [];
    if (widget.showShoppingCart) actions.add(PrimaryCartButton());
    if (widget.right != null)
      actions.addAll(widget.right);
    else
      actions.add(Container());

    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: GradientColor.of(context).primaryLinearGradient,
        ),
      ),
      elevation: 4,
      centerTitle: true,
      bottom: widget.bottom,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: colors.colorScheme.onPrimary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: _titleMaker(widget.tittle),
      actions: actions,
    );
  }

  Widget _titleMaker(tittle) {
    if (tittle != null) {
      return Text(
        tittle,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
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
