import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/models/stockModel.dart';

class StockItem extends StatefulWidget {
  final StockModel stockModel;

  const StockItem({Key key, this.stockModel}) : super(key: key);

  @override
  _StockItemState createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
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
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            child: Image.network(
              widget.stockModel.images[0],
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  widget.stockModel.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: colors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  '${widget.stockModel.price ?? "Chưa cập nhật"} / ${widget.stockModel.unit ?? "Chưa cập nhật"}'),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 80,
                child: Center(
                    child: Text(
                  'Số lượng',
                  style: TextStyle(color: colors.primaryColor),
                )),
              ),
              SizedBox(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Text(
                    '12'
//                          '${widget.stockModel.toString()} ${widget.stockModel.unit}'
                          ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
