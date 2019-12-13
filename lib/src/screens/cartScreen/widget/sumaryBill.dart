import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/state.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';

class SummaryBill extends StatefulWidget {
  final BillModel currentBill;

  const SummaryBill({Key key, @required this.currentBill}) : super(key: key);

  @override
  _SummaryBillState createState() => _SummaryBillState();
}

class _SummaryBillState extends State<SummaryBill> {
  final CartBloc _cartBloc = CartBloc();

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
                BlocBuilder(
                  bloc: _cartBloc,
                  builder: (BuildContext context, state) {
                    if (state is CartBlocSaved || state is CartBlocFetched) {
                      var listDishes = _cartBloc.currentCart.listDishes;
                      int sum = 0;
                      for (int i = 0; i < listDishes.length; i++) {
                        sum += listDishes[i].quantity * listDishes[i].price;
                      }
                      return Text('$sum VNĐ');
                    }
                    return Text('Đang tải...');
                  },
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
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Nhập mã giảm giá..."),
          ),

          actions: <Widget>[
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).colorScheme.error,
              child: new Text(
                "Đóng",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).primaryColor,
              child: new Text(
                "Xác nhận",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
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

  int _calculateSummaryBill()
  {
    int total = 0;
    widget.currentBill.dishes.forEach( (item) {
      total = total + item.quantity*(item.price ?? item.dish.defaultPrice);
    });
    return total;
  }
}
