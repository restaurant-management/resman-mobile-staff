import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';

class BillStatusItem extends StatefulWidget {
  final BillModel bill;
  BillStatusItem({Key key, this.bill})
      : super(key: key);

  _BillStatusItem createState() =>_BillStatusItem();
}

class _BillStatusItem extends State<BillStatusItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
         Container(
            width: 400,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
               borderRadius: const BorderRadius.all(const Radius.circular(90)),
            ),
            child: Center(
              child: Text(
              "Hoa don ${widget.bill.billId}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
              ),
        )
          ),
          Positioned(
            right: 20,
            top: 12.5,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: new BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(90),
              ),
              constraints: BoxConstraints(
                minWidth: 25,
                minHeight: 25,
              ),
              child: Center(
                child: Text(
                    '${widget.bill.collectValue}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          )
      ],
    )
    ;
  }
}
