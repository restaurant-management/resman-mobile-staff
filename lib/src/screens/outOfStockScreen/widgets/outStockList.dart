import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/screens/outOfStockScreen/widgets/OutStockItem.dart';

class OutStockList extends StatefulWidget {
  final List<DailyDishModel> dailyDish;

  final double headerHeight;
  final double footerHeight;

  const OutStockList({Key key, this.headerHeight, this.footerHeight, this.dailyDish})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _OutStockListState();
}

class _OutStockListState extends State<OutStockList> {
  List<DailyDishModel> get items => widget.dailyDish;

  double get headerHeight => widget.headerHeight;

  double get footerHeight => widget.footerHeight;

  _OutStockListState();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
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
                    OutStockItem(
                      dailyDish: items[index],
                    ),
                  ],
                );
              else if (index == items.length - 1)
                return Column(
                  children: <Widget>[
                    OutStockItem(
                      dailyDish: items[index],
                    ),
                    footerHeight != null
                        ? SizedBox(
                            height: footerHeight + 8,
                          )
                        : Container(),
                  ],
                );
              return OutStockItem(
                dailyDish: items[index],
              );
            }),
//        ListView.builder(
//            scrollDirection: Axis.vertical,
//            itemCount: items.length,
//            itemBuilder: (context, index) {
//              final item = items[index].dishId.toString();
//              if (index == 0)
//                return Column(
//                  children: <Widget>[
//                    headerHeight != null
//                        ? SizedBox(
//                            height: headerHeight,
//                          )
//                        : Container(),
//                    Dismissible(
//                      key: Key(item),
//                      onDismissed: (direct) {
//                        onDismissed(items[index].dishId);
//                      },
//                      child: OutStockItem(
//                        cartDish: items[index],
//                      ),
//                    ),
//                  ],
//                );
//              else if (index == items.length - 1)
//                return Column(
//                  children: <Widget>[
//                    Dismissible(
//                      key: Key(item),
//                      onDismissed: (direct) {
//                        onDismissed(items[index].dishId);
//                      },
//                      child: OutStockItem(
//                        cartDish: items[index],
//                      ),
//                    ),
//                    footerHeight != null
//                        ? SizedBox(
//                            height: footerHeight + 8,
//                          )
//                        : Container(),
//                  ],
//                );
//              return Dismissible(
//                  key: Key(item),
//                  onDismissed: (direct) {
//                    onDismissed(items[index].dishId);
//                  },
//                  child: OutStockItem(
//                    cartDish: items[index],
//                  ));
//            })
      ],
    );
  }

  void onDismissed(int dishId) {}
}
