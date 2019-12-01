import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';

import 'dishItem.dart';

class DishList extends StatefulWidget {
  final double headerHeight;
  final double footerHeight;
  final List<BillDishModel> billDetails;

  const DishList(
      {Key key,
        this.headerHeight,
        this.footerHeight,
        @required this.billDetails})
      : assert(billDetails != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  List<BillDishModel> get items => widget.billDetails;

  double get headerHeight => widget.headerHeight;

  double get footerHeight => widget.footerHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (index == 0)
            return Column(
              children: <Widget>[
                headerHeight != null
                    ? SizedBox(
                  height: headerHeight,
                )
                    : Container(),
                DishItem(
                  billDishModel: items[index],
                ),
              ],
            );
          else if (index == items.length - 1)
            return Column(
              children: <Widget>[
                DishItem(
                  billDishModel: items[index],
                ),
                footerHeight != null
                    ? SizedBox(
                  height: footerHeight + 8,
                )
                    : Container(),
              ],
            );
          return DishItem(
            billDishModel: items[index],
          );
        });
  }
}
