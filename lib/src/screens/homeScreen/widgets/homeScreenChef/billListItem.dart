import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/billDetailScreen.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';

class BillListItem extends StatefulWidget {
  final String btnText;
  final BillModel bill;
  final int count;
  final Function onPressed;
  final IconData icon;

  BillListItem({Key key, this.bill, this.count, this.onPressed, this.icon, this.btnText})
      : super(key: key);

  _BillListItemState createState() => _BillListItemState();
}

class _BillListItemState extends State<BillListItem> {
  @override
  Widget build(BuildContext context) {
    var bill = widget.bill;
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BillDetailScreen(
                      billId: widget.bill.id,
                    )));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(0),
                    color: Color.fromRGBO(88, 37, 176, 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Mã: ${bill.id ?? ""}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(0),
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        _mapBillStatus(bill),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Số món',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${widget.count ?? 0}")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 1,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Thời gian',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(DateFormat('hh:mm dd/MM/yyyy')
                            .format(bill.createAt))
                      ],
                    ),
                  ),
                ],
              ),
              _buildButton(context, bill)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, BillModel bill) {
    return _buildButtonWidget( widget.btnText ?? 'Xác nhận chuẩn bị',
        increaseWidthBy: 90, onPressed: widget.onPressed);
  }

  Widget _buildButtonWidget(String text,
      {VoidCallback onPressed, double increaseWidthBy = 60}) {
    bool isUpdating = true;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GradientButton(
          child: Text(text),
          increaseWidthBy: increaseWidthBy,
          callback: onPressed,
          gradient: GradientColor.of(context).primaryLinearGradient,
        ),
      ],
    );
  }

  String _mapBillStatus(BillModel bill) {
    var status = bill.getStatus();
    if (status == "Prepared")
      return 'Chưa thanh toán';
    else if (status == "Preparing")
      return 'Đang chuẩn bị';
    else if (status == "Ordered") return 'Chuẩn bị xong';
    return 'Chưa chuẩn bị';
  }
}
