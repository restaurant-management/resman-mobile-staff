import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';
import 'package:resman_mobile_staff/src/widgets/dishList/dishItemCard.dart';
import 'package:resman_mobile_staff/src/widgets/dishList/dishListItem.dart';

class DishesList extends StatefulWidget {
  final List<DishModal> dishList;
  final String note;

  const DishesList({Key key, @required this.dishList, @required this.note})
      : assert(dishList != null),
        super(key: key);

  @override
  _DishesListState createState() => _DishesListState();
}

class _DishesListState extends State<DishesList> {
  List<DishModal> get listDailyDish => widget.dishList;

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

  List<Widget> _buildRow(List<DishModal> listDailyDish) {
    List<Widget> rows = [];
    for (int i = 0; i < listDailyDish.length; i += 2) {
      rows.add(SizedBox(
        height: 10,
      ));
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DishListItem(dish: listDailyDish[i], note: widget.note),
          i + 1 < listDailyDish.length
              ? DishListItem(
                  dish: listDailyDish[i + 1],
                  note: widget.note,
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
