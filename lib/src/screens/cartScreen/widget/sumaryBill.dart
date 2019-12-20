import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/state.dart';
import 'package:resman_mobile_staff/src/models/cartModel.dart';

class SummaryBill extends StatefulWidget {
  final CartModel currentCart;

  const SummaryBill({Key key, @required this.currentCart}) : super(key: key);

  @override
  _SummaryBillState createState() => _SummaryBillState();
}

class _SummaryBillState extends State<SummaryBill> {
  final CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BlocListener(
      bloc: _cartBloc,
      child: BlocBuilder(
        bloc: _cartBloc,
        builder: (BuildContext context, state) {
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
                              color: primaryColor, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        BlocBuilder(
                          bloc: _cartBloc,
                          builder: (BuildContext context, state) {
                            if (state is CartBlocSaved ||
                                state is CartBlocFetched) {
                              var listDishes = _cartBloc.currentCart.listDishes;
                              double sum = 0;
                              for (int i = 0; i < listDishes.length; i++) {
                                sum +=
                                    listDishes[i].quantity * listDishes[i].price;
                              }

                              if (_cartBloc.currentCart.discountCode != null)
                                {
                                  double discount = sum * _cartBloc.currentCart.discountCode.discount/100;
                                  if (discount > _cartBloc.currentCart.discountCode.maxPriceDiscount)
                                    discount = _cartBloc.currentCart.discountCode.maxPriceDiscount;
                                  sum -= discount;
                                }

                              return Text('${sum.round() ?? 0} VNĐ');
                            }
                            return Text('Đang tải...');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 1,
                    child: Container(
                      color: primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        splashColor: primaryColor,
                        onTap: _showSelectTableNumber,
                        child: BlocBuilder(
                          bloc: _cartBloc,
                          builder: (BuildContext context, state) {
                            if (state is CartBlocSaved ||
                                state is CartBlocFetched) {
                            var discountText = 'Mã giảm giá?';
                            if (_cartBloc.currentCart.discountCode != null)
                            {
                              discountText = _cartBloc.currentCart.discountCode.code;
                            }
                            return Text(
                              discountText,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              overflow: TextOverflow.ellipsis,
                            );
                            }
                            return Text(
                                'Mã giảm giá?',
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      listener: (BuildContext context, CartBlocState state) {
        if (state is CartBlocAddedDiscountFailure) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Mã giảm giá không hợp lệ!"),
                actions: <Widget>[
                  new CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    minSize: 20,
                    color: Theme.of(context).primaryColor,
                    child: new Text(
                      "Oke",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          _cartBloc.dispatch(SaveCartBloc());
        }
      },
    );
  }

  void _showSelectTableNumber() {
    showDialog(
      context: context,
      builder: (_) {
        return DiscountInputDialog();
      },
    );
  }
}

class DiscountInputDialog extends StatefulWidget {
  @override
  _DiscountInputDialogState createState() => _DiscountInputDialogState();
}

class _DiscountInputDialogState extends State<DiscountInputDialog> {
  bool isDiscountCodeValid = true;
  var discountCodeController = TextEditingController();
  final CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text("Mã giảm giá"),
      content: TextField(
        controller: discountCodeController,
        inputFormatters: <TextInputFormatter>[
          BlacklistingTextInputFormatter.singleLineFormatter,
        ],
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: "Nhập mã giảm giá...",
          errorText: isDiscountCodeValid ? null : "Vui lòng nhập mã giảm giá",
        ),
      ),
      actions: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          minSize: 20,
          color: Theme.of(context).colorScheme.error,
          child: new Text(
            "Đóng",
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
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
            if (discountCodeController.text.isEmpty) {
              setState(() {
                isDiscountCodeValid = false;
              });
            } else {
              setState(() {
                isDiscountCodeValid = true;
              });
              _cartBloc.dispatch(AddDiscountCode(discountCodeController.text));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
