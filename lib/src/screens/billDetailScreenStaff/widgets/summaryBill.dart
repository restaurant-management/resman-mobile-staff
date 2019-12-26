import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/utils/textStyle.dart';

class SummaryBill extends StatelessWidget {
  final List<BillDishModel> billDetails;

  const SummaryBill({Key key, @required this.billDetails})
      : assert(billDetails != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final colorScheme = Theme.of(context).colorScheme;
    var sum = 0;
    for (int i = 0; i < billDetails.length; i++) {
      sum += billDetails[i].quantity * billDetails[i].price;
    }
    return Card(
      margin: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(
                'Tổng tiền: ',
                style: TextStyles.body1.merge(
                  TextStyle(color: primaryColor, fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(
                '$sum',
                style: TextStyles.body1.merge(
                  TextStyle(color: colorScheme.onSurface, fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
