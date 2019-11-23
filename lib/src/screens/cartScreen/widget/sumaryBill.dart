import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SummaryBill extends StatefulWidget {
  @override
  _SummaryBillState createState() => _SummaryBillState();
}

class _SummaryBillState extends State<SummaryBill> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: EdgeInsets.all(0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Tổng tiền',
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('100 000 VNĐ')
              ],
            ),
            SizedBox(
              height: 30,
              width: 1,
              child: Container(
                color: primaryColor,
              ),
            ),
            InkWell(
              splashColor: primaryColor,
              onTap: _showSelectTableNumber,
              child: Text(
                'Mã giảm giá?',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSelectTableNumber() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Mã giảm giá"),
          content: TextField(
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Colors.grey
                ),
                hintText: "Nhập mã giảm giá..."
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Đóng"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Xác nhận"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
