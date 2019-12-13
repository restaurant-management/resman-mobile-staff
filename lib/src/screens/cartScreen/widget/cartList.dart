import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/state.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/billDetailScreen.dart';
import 'package:resman_mobile_staff/src/widgets/loadingIndicator.dart';

import 'cartItem.dart';

class CartList extends StatefulWidget {
  final double headerHeight;
  final double footerHeight;

  const CartList({Key key, this.headerHeight, this.footerHeight})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final CartBloc _cartBloc = CartBloc();

  List<CartDishModel> get items => _cartBloc.currentCart.listDishes;

  double get headerHeight => widget.headerHeight;

  double get footerHeight => widget.footerHeight;

  _CartListState();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cartBloc,
      child: BlocBuilder(
        bloc: _cartBloc,
        builder: (BuildContext context, state) {
          if (state is CartBlocInitialize) {
            _cartBloc.dispatch(FetchCartBloc());
            return LoadingIndicator();
          }
          if (state is CartBlocFetching || state is CartBlocCreatingBill)
            return LoadingIndicator();
          if (state is CartBlocSaving || state is CartBlocCreateBillFailure)
            return Stack(
              children: <Widget>[
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index].dishId.toString();
                      if (index == 0)
                        return Column(
                          children: <Widget>[
                            headerHeight != null
                                ? SizedBox(
                              height: headerHeight,
                            )
                                : Container(),
                            Dismissible(
                              key: Key(item),
                              onDismissed: (direct) {
                                onDismissed(items[index].dishId);
                              },
                              child: CartItem(
                                cartDish: items[index],
                              ),
                            ),
                          ],
                        );
                      else if (index == items.length - 1)
                        return Column(
                          children: <Widget>[
                            Dismissible(
                              key: Key(item),
                              onDismissed: (direct) {
                                onDismissed(items[index].dishId);
                              },
                              child: CartItem(
                                cartDish: items[index],
                              ),
                            ),
                            footerHeight != null
                                ? SizedBox(
                              height: footerHeight + 8,
                            )
                                : Container(),
                          ],
                        );
                      return Dismissible(
                          key: Key(item),
                          onDismissed: (direct) {
                            onDismissed(items[index].dishId);
                          },
                          child: CartItem(
                            cartDish: items[index],
                          ));
                    }),
                LoadingIndicator(),
              ],
            );
          if (state is CartBlocCreatedBill)
            return Container(
              child: Center(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => BillDetailScreen(
                          bill: state.bill,
                        ),
                      ),
                    );
                  },
                  child: Text('Xem hoá đơn'),
                ),
              ),
            );

          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index].dishId.toString();
                if (index == 0)
                  return Column(
                    children: <Widget>[
                      headerHeight != null
                          ? SizedBox(
                        height: headerHeight,
                      )
                          : Container(),
                      Dismissible(
                        key: Key(item),
                        onDismissed: (direct) {
                          onDismissed(items[index].dishId);
                        },
                        child: CartItem(
                          cartDish: items[index],
                        ),
                      ),
                    ],
                  );
                else if (index == items.length - 1)
                  return Column(
                    children: <Widget>[
                      Dismissible(
                        key: Key(item),
                        onDismissed: (direct) {
                          onDismissed(items[index].dishId);
                        },
                        child: CartItem(
                          cartDish: items[index],
                        ),
                      ),
                      footerHeight != null
                          ? SizedBox(
                        height: footerHeight + 8,
                      )
                          : Container(),
                    ],
                  );
                return Dismissible(
                    key: Key(item),
                    onDismissed: (direct) {
                      onDismissed(items[index].dishId);
                    },
                    child: CartItem(
                      cartDish: items[index],
                    ));
              });
        },
      ),
      listener: (BuildContext context, CartBlocState state) {
        if (state is CartBlocCreateBillFailure) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Bạn không thể tạo hoá đơn!"),
                content: new Text("Hãy liên hệ với nhân viên, để đặt món."),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Oke"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          _cartBloc.dispatch(FetchCartBloc());
        }
      },
    );
  }

  void onDismissed(int dishId) {
    _cartBloc.dispatch(RemoveDishFromCart(dishId));
  }
}
