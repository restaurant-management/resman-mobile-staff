import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/utils/textStyle.dart';

class SummaryBill extends StatelessWidget {
  final BillModel bill;

  const SummaryBill({Key key, @required this.bill})
      : assert(bill != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.all(0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Text(
                    'Tổng tiền',
                    style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${bill.realPrice.floor()} VNĐ',
                    style: TextStyles.h3
                        .merge(TextStyle(color: colorScheme.onBackground)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
              width: 1,
              child: Container(
                color: colorScheme.primary,
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      bill.discountCode != null
                          ? Text(
                        'Giảm giá: ${bill.discountCode} (-${bill.discountValue}%)',
                        style: TextStyle(color: Colors.black),
                      )
                          : Container(),
                      bill.voucherCode != null
                          ? Text(
                        'Voucher: -${bill.voucherValue}${bill.voucherIsPercent ? '%' : 'VNĐ'}',
                        style: TextStyle(color: Colors.black),
                      )
                          : Container(),
                      bill.voucherCode == null && bill.discountCode == null
                          ? Text(
                        'Không có mã giảm giá!',
                        style: TextStyles.h4.merge(
                            TextStyle(color: colorScheme.onBackground)),
                      )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}