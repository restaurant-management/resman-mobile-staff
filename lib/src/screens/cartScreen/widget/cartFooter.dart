import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';
import 'package:qrscan/qrscan.dart' as scanner;

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
  final tableNumberController = TextEditingController();
  CartBloc _cartBloc = CartBloc();
  String note;
  final noteTextFieldController = TextEditingController();
  Repository _repository = Repository();
  String customerUuid;

  @override
  void dispose() {
    // TODO: implement dispose
    noteTextFieldController.dispose();
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
            SummaryBill(
              currentCart: _repository.currentCart,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GradientButton(
                increaseWidthBy: 100,
                increaseHeightBy: MediaQuery.of(context).size.height * 0.01,
                child: Text('Tạo hoá đơn'),
                gradient: GradientColor.of(context).primaryLinearGradient,
                callback: _showAddNote,
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
            controller: tableNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
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
              onPressed: () async {
                Navigator.of(context).pop();
                int tableNumber =
                    int.parse(tableNumberController.value?.text ?? 0);
                try {
                  _cartBloc.add(CreateBillFromCart(tableNumber, customerUuid: customerUuid));
                } catch (e) {
                  _showCreateFail();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future _showSelectCustomer() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Chọn khách hàng"),
          actions: <Widget>[
            new CupertinoButton(
              child: new Text("Bỏ qua"),
              onPressed: () {
                Navigator.of(context).pop();
                _showSelectTableNumber();
              },
            ),
            new CupertinoButton(
              child: new Text("Quét mã QR"),
              onPressed: () async {
                String cameraScanResult = await scanner.scan();
                setState(() {
                  customerUuid = cameraScanResult;
                });
                Navigator.of(context).pop();
                _showSelectTableNumber();
              },
            ),
          ],
        );
      },
    );
  }

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

  void _showCreateFail() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Tạo hóa đơn thất bại"),
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

  void _showAddNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Ghi chú"),
          content: TextField(
            controller: noteTextFieldController,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Nhập ghi chú..."),
          ),
          actions: <Widget>[
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).colorScheme.error,
              child: new Text(
                "Bỏ qua",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              onPressed: () {
                note = "";
                Navigator.of(context).pop();
                _showSelectCustomer();
              },
            ),
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
                note = noteTextFieldController.text ?? "";
                _repository.addBillNote(note);
                Navigator.of(context).pop();
                _showSelectCustomer();
              },
            ),
          ],
        );
      },
    );
  }
}
