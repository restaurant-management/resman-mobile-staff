import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/stockModel.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenWareManager/stockItem.dart';


class StockList extends StatefulWidget {
  final double headerHeight;
  final double footerHeight;
  final List<StockModel> stockList;

  const StockList(
      {Key key,
        this.headerHeight,
        this.footerHeight,
        @required this.stockList})
      : assert(stockList != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  List<StockModel> get items => widget.stockList;

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
                StockItem(
                  stockModel: items[index],
                ),
              ],
            );
          else if (index == items.length - 1)
            return Column(
              children: <Widget>[
                StockItem(
                  stockModel: items[index],
                ),
                footerHeight != null
                    ? SizedBox(
                  height: footerHeight + 8,
                )
                    : Container(),
              ],
            );
          return StockItem(
            stockModel: items[index],
          );
        });
  }
}
