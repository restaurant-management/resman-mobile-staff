import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/models/dailyDish.dart';
import 'package:resman_mobile_staff/src/widgets/dishList/dishItemCard.dart';

class DishesList extends StatefulWidget {
  final List<DailyDish> listDailyDish;

  const DishesList({Key key, @required this.listDailyDish})
      : assert(listDailyDish != null),
        super(key: key);

  @override
  _DishesListState createState() => _DishesListState();
}

class _DishesListState extends State<DishesList> {
  List<DailyDish> get listDailyDish => widget.listDailyDish;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Column(
            children: _buildRow(listDailyDish),
          ),
        ));
  }

  List<Widget> _buildRow(List<DailyDish> listDailyDish) {
    List<Widget> rows = [];
    for (int i = 0; i < listDailyDish.length; i += 2) {
      rows.add(SizedBox(
        height: 10,
      ));
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DishItemCard(
            dailyDish: listDailyDish[i],
          ),
          i + 1 < listDailyDish.length
              ? DishItemCard(
            dailyDish: listDailyDish[i + 1],
          )
              : Container(
            width: MediaQuery.of(context).size.width / 2.2,
          ),
        ],
      ));
    }
    rows.add(SizedBox(
      height: 60,
    ));
    return rows;
  }
}
