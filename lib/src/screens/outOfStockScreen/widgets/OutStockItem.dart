import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';

class OutStockItem extends StatefulWidget {
  final DailyDishModel dailyDish;

  const OutStockItem({Key key, @required this.dailyDish})
      : assert(dailyDish != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _OutStockItemState();
}

class _OutStockItemState extends State<OutStockItem> {
  DailyDishModel get dailyDish => widget.dailyDish;

  @override
  void initState() {
    super.initState();
  }

  void _showAccept() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Báo hết món'),
          content: Text('Món ' + dailyDish.dish.name.toString() + ' đã hết?'),
          actions: <Widget>[
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).colorScheme.secondary,
              child: new Text(
                "Close",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).primaryColor,
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
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
                dailyDish.dish.images[0],
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              )),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    dailyDish.dish.name ?? 'Chưa cập nhật',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  dailyDish.day.toString(),
                  maxLines: 1,
                ),
              ],
            ),
          ),
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
