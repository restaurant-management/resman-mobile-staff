import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/models/stockModel.dart';
import 'package:resman_mobile_staff/src/screens/importBillScreen/widgets/importItem.dart';

class ListImport extends StatefulWidget {
  final List<StockModel> items;
  final double headerHeight;
  final double footerHeight;

  const ListImport({Key key, this.items, this.headerHeight, this.footerHeight})
      : super(key: key);

  @override
  _ListImportState createState() => _ListImportState();
}

class _ListImportState extends State<ListImport> {
  List<StockModel> get items => widget.items;

  double get headerHeight => widget.headerHeight;

  double get footerHeight => widget.footerHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
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
                ImportItem(
                  stockModel: items[index],
                ),
              ],
            );
          else if (index == items.length - 1)
            return Column(
              children: <Widget>[
                ImportItem(
                  stockModel: items[index],
                ),
                footerHeight != null
                    ? SizedBox(
                        height: footerHeight + 8,
                      )
                    : Container(),
              ],
            );
          return ImportItem(
            stockModel: items[index],
          );
        },
      ),
    );
  }
}
