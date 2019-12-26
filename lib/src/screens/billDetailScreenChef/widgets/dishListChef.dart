import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';

import 'dishItemChef.dart';

class DishListChef extends StatefulWidget {
  final double headerHeight;
  final double footerHeight;
  final List<BillDishModel> billDetails;

  const DishListChef(
      {Key key,
      this.headerHeight,
      this.footerHeight,
      @required this.billDetails})
      : assert(billDetails != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _DishListChefState();
}

class _DishListChefState extends State<DishListChef> {
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
                DishItemChef(
                  billDishModel: items[index],
                ),
              ],
            );
          else if (index == items.length - 1)
            return Column(
              children: <Widget>[
                DishItemChef(
                  billDishModel: items[index],
                ),
                footerHeight != null
                    ? SizedBox(
                        height: footerHeight + 8,
                      )
                    : Container(),
              ],
            );
          return DishItemChef(
            billDishModel: items[index],
          );
        });
  }
}
