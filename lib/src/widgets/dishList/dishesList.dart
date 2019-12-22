import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';

import 'dishItemCard.dart';

class DishesList extends StatefulWidget {
  final List<DailyDishModel> listDailyDish;

  const DishesList({Key key, @required this.listDailyDish})
      : assert(listDailyDish != null),
        super(key: key);

  @override
  _DishesListState createState() => _DishesListState();
}

class _DishesListState extends State<DishesList> {
  List<DailyDishModel> get listDailyDish => widget.listDailyDish;

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

  List<Widget> _buildRow(List<DailyDishModel> listDailyDish) {
    List<Widget> rows = [];
    for (int i = 0; i < listDailyDish.length; i += 2) {
      rows.add(SizedBox(
        height: 10,
      ));
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: DishItemCard(
                dailyDish: listDailyDish[i],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: i + 1 < listDailyDish.length
                  ? DishItemCard(
                dailyDish: listDailyDish[i + 1],
              )
                  : Container(),
            ),
          ],
        ),
      ));
    }
    rows.add(SizedBox(
      height: 60,
    ));
    return rows;
  }
}