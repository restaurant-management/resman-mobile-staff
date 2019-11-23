import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/billDetailScreen.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreenChef/billDetailScreenChef.dart';

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

    return Badge(
      badgeContent: widget.isDone
          ? Icon(Icons.check)
          : Text(widget.badgeNumber.toString()),
      animationType: BadgeAnimationType.scale,
      badgeColor: widget.isDone ? colorScheme.background : colorScheme.error,
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
                      "Bàn",
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
          widget.isDone ? _showPayment() : _navigateToBillStaffDetail();
        },
      ),
    );
  }

  void _navigateToBillStaffDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillDetailScreenChef(),
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
            new FlatButton(
              child: new Text("Giá trị khác"),
              onPressed: () {
                Navigator.of(context).pop();
                _showChangeToltalDialog();
              },
            ),
            new FlatButton(
              child: new Text("Xác nhận"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showChangeToltalDialog() {
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
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      labelText: "Tổng tiền",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: "200.000VND",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                      ),
                      fillColor: Colors.grey,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                          color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if ( val.isEmpty || int.parse(val) < 1000) {
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Xác nhận"),
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
