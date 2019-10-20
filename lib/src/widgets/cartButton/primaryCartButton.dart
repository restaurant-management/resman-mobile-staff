import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryCartButton extends StatefulWidget {
  final Color color;

  const PrimaryCartButton({Key key, this.color}) : super(key: key);

  @override
  _PrimaryCartButtonState createState() => _PrimaryCartButtonState();
}

class _PrimaryCartButtonState extends State<PrimaryCartButton> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Stack(children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: widget.color != null
                ? widget.color
                : Theme.of(context).primaryColor,
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Icon(
                Icons.brightness_1,
                color: Colors.red,
                size: 20,
              ),
              Text(
                _count.toString(),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        )
      ]),
    );
  }
}
