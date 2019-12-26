import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BillStatusItem extends StatefulWidget {
  final String content;
  final int number;

  BillStatusItem({Key key, this.content, this.number}) : super(key: key);

  _BillStatusItem createState() => _BillStatusItem();
}

class _BillStatusItem extends State<BillStatusItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 2, color: Colors.black),
              borderRadius: const BorderRadius.all(const Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                widget.content,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0),
              ),
            )),
//        Positioned(
//          right: 30,
//          top: 12.5,
//          child: Container(
//              padding: EdgeInsets.all(2),
//              decoration: new BoxDecoration(
//                color: Colors.red,
//                borderRadius: BorderRadius.circular(90),
//              ),
//              constraints: BoxConstraints(
//                minWidth: 25,
//                minHeight: 25,
//              ),
//              child: Center(
//                child: Text(
//                  '${widget.number}',
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 13,
//                  ),
//                  textAlign: TextAlign.center,
//                ),
//              )),
//        )
      ],
    );
  }
}
