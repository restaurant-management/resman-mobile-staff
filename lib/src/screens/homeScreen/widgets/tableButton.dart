import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/billDetailScreen.dart';

class TableButton extends StatefulWidget {
  final int tableNumber;
  final int badgeNumber;

  const TableButton({Key key, this.tableNumber, this.badgeNumber})
      : super(key: key);

  @override
  _TableButtonState createState() => _TableButtonState();
}

class _TableButtonState extends State<TableButton> {
  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ThemeData colorTheme = Theme.of(context);

    return Badge(
      badgeContent: Text(widget.badgeNumber.toString()),
      animationType: BadgeAnimationType.scale,
      position: BadgePosition.topRight(top: 10, right: 10),
      child: CupertinoButton(
        child: Container(
//          margin: const EdgeInsets.only(left: 10, right: 10),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 2, color: colorTheme.accentColor),
            borderRadius: const BorderRadius.all(const Radius.circular(10)),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Ban",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.tableNumber.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 48.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BillDetailScreen(),
            ),
          );
        },
      ),
    );
  }
}
