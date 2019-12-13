import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';
import 'sumaryBill.dart';
//import 'package:qrcode_reader/qrcode_reader.dart';

class CartFooter extends StatefulWidget {
  final double height;
  final bool hasCreateButton;

  const CartFooter(
      {Key key, @required this.height, this.hasCreateButton = true})
      : super(key: key);

  @override
  _CartFooterState createState() => _CartFooterState();
}

class _CartFooterState extends State<CartFooter> {
  bool _isCreating = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Repository _repository = new Repository();
    return Container(
      height: widget.height,
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SummaryBill(currentBill: _repository.currentBill,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GradientButton(
                increaseWidthBy: 100,
                increaseHeightBy: MediaQuery.of(context).size.height * 0.01,
                child: Text('Tạo hoá đơn'),
                gradient: GradientColor.of(context).primaryLinearGradient,
                callback: _showSelectTableNumber,
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
          title: Text("Chọn số bàn"),
          content: TextField(
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Nhập số bàn..."),
          ),
          actions: <Widget>[
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).primaryColor,
              child: new Text(
                "Xác nhận",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
//                _showSelectCustomer();
                _showCreateSuccess();
              },
            ),
          ],
        );
      },
    );
  }

//  void _showSelectCustomer() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: Text("Chọn khách hàng"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Bỏ qua"),
//              onPressed: () {
//                Navigator.of(context).pop();
//                _showCreateSuccess();
//              },
//            ),
//            new FlatButton(
//              child: new Text("Quét mã QR"),
//              onPressed: () async {
////                Future<String> futureString = new QRCodeReader().scan();
//                Navigator.of(context).pop();
//                _showCreateSuccess();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  void _showCreateSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Tạo hóa đơn thành công"),
          actions: <Widget>[
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).primaryColor,
              child: new Text(
                "Đóng",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
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
