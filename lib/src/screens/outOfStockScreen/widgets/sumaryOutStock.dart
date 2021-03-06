import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SummaryOutStock extends StatelessWidget {
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
                  'Tổng số món hết',
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
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
              onTap: () {},
              child: Text(
                '10',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
