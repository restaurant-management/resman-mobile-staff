import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';

class SummaryBill extends StatelessWidget {
  final List<BillDishModel> billDetails;

  const SummaryBill({Key key, @required this.billDetails})
      : assert(billDetails != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    var sum = 0;
    for (int i = 0; i < billDetails.length; i++) {
      sum += billDetails[i].quantity * billDetails[i].price;
    }
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
                Text('$sum VNĐ')
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
                'Mã giảm giá?',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
