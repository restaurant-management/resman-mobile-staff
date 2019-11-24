import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/stockModel.dart';
import 'package:resman_mobile_staff/src/screens/homeScreen/widgets/homeScreenWareManager/stockItem.dart';
import 'package:resman_mobile_staff/src/utils/textStyle.dart';

class StockList extends StatefulWidget {
  final String headerContent;
  final double headerHeight;
  final double footerHeight;
  final List<StockModel> stockList;

  const StockList(
      {Key key,
      this.headerHeight,
      this.footerHeight,
      @required this.stockList,
      this.headerContent})
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.headerContent,
                              style: TextStyles.h4Headline.merge(
                                TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ),
                        ),
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
