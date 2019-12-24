import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenStaff/billDetailScreenStaff.dart';

class TableButton extends StatefulWidget {
  final int tableNumber;
  final int badgeNumber;
  final bool isDone;

  const TableButton({Key key, this.tableNumber, this.badgeNumber, this.isDone})
      : super(key: key);

  @override
  _TableButtonState createState() => _TableButtonState();
}

class _TableButtonState extends State<TableButton> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ThemeData colorTheme = Theme.of(context);

//    padding: EdgeInsets.all(0),
//    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
//    height: 15,
//    width: 15,
//    alignment: Alignment(0.0, 0.0),

    return Badge(
      shape: BadgeShape.circle,
      badgeContent: SizedBox(
        width: 12,
        height: 12,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: widget.isDone
              ? Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                )
              : Text(widget.badgeNumber.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  )),
        ),
      ),
      animationType: BadgeAnimationType.scale,
      badgeColor: widget.isDone ? colorScheme.onSurface : colorScheme.error,
      position: BadgePosition.topRight(top: 10, right: 10),
      child: CupertinoButton(
        child: Container(
//          margin: const EdgeInsets.only(left: 10, right: 10),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 2, color: colorTheme.primaryColor),
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
                      "Bàn",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onBackground,
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
                          color: colorScheme.onBackground,
                          fontSize: 48.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onPressed: () {
          widget.isDone ? _showPayment() : _navigateToBillStaffDetail();
        },
      ),
    );
  }

  void _navigateToBillStaffDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillDetailScreenStaff(),
      ),
    );
  }

  void _showPayment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Thanh toán hóa đơn"),
          content: Text("Tổng tiền là 100000VND?"),
          actions: <Widget>[
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).colorScheme.onSurface,
              child: new Text(
                "Giá trị khác",
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showChangeTotalDialog();
              },
            ),
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).primaryColor,
              child: new Text(
                "Xác nhận",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showChangeTotalDialog() {
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Thanh toán hóa đơn"),
          content: SizedBox(
            width: 500,
            child: Form(
              key: _formKey,
              child: Wrap(
                runSpacing: 10,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    initialValue: "100000",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      labelText: "Tổng tiền",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      fillColor: Colors.grey,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val.isEmpty || int.parse(val) < 1000) {
                        return "Giá tiền phải lớn hơn 1000";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Ghi chú...",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).primaryColor,
              child: new Text(
                "Xác nhận",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
