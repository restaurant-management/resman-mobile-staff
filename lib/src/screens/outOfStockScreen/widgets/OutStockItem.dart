import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';

class OutStockItem extends StatefulWidget {
  final CartDishModel cartDish;

  const OutStockItem({Key key, @required this.cartDish})
      : assert(cartDish != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _OutStockItemState();
}

class _OutStockItemState extends State<OutStockItem> {
  CartDishModel get cartDish => widget.cartDish;

  int _count;

  @override
  void initState() {
    _count = cartDish.quantity;
    super.initState();
  }

  void _showAccept() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Báo hết món'),
          content: Text('Món ' + cartDish.dishId.toString() + ' đã hết?'),
          actions: <Widget>[
            new CupertinoButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new CupertinoButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              child: Image.network(
                FakeData.dailyDish.dish.images[0],
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              )),
          SizedBox(
            height: 60,
            width: 60,
            child: CupertinoButton(
              color: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Icon(
                Icons.cancel,
                color: primaryColor,
              ),
              onPressed: _showAccept,
            ),
          ),
        ],
      ),
    );
  }
}
