import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/models/stockModel.dart';
import 'package:resman_mobile_staff/src/utils/textStyle.dart';

class ImportItem extends StatefulWidget {
  final StockModel stockModel;

  const ImportItem({Key key, this.stockModel}) : super(key: key);

  @override
  _ImportItemState createState() => _ImportItemState();
}

class _ImportItemState extends State<ImportItem> {
  int _count;

  @override
  void initState() {
    _count = 1;
    super.initState();
  }

  void _increase() {
    setState(() {
      _count = _count + 1;
    });
  }

  void _decrease() {
    setState(() {
      _count = _count == 1 ? _count : _count - 1;
    });
  }

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
                    color: colors.colorScheme.onBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: widget.stockModel.price.toString(),
                    ),
                  ),
                  Text(
                    '/${widget.stockModel.unit ?? "Chưa cập nhật"}',
                    style: TextStyles.h6Headline.merge(
                      TextStyle(color: colors.colorScheme.onSurface),
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 60,
                child: FlatButton(
                  color: Colors.white,
                  splashColor: colors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: colors.primaryColor,
                  ),
                  onPressed: _increase,
                ),
              ),
              SizedBox(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Text(_count.toString()),
                    ],
                  )),
              SizedBox(
                height: 25,
                width: 60,
                child: FlatButton(
                  color: Colors.white,
                  splashColor: colors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: colors.primaryColor,
                  ),
                  onPressed: _decrease,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
