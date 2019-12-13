import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_staff/src/blocs/cartItemBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartItemBloc/event.dart';
import 'package:resman_mobile_staff/src/blocs/cartItemBloc/state.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';

class CartItem extends StatefulWidget {
  final CartDishModel cartDish;

  const CartItem({Key key, @required this.cartDish})
      : assert(cartDish != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final CartBloc _cartBloc = CartBloc();
  final CartItemBloc _cartItemBloc = CartItemBloc();

  CartDishModel get cartDish => widget.cartDish;

  int _count;

  @override
  void initState() {
    _count = cartDish.quantity;
    super.initState();
  }

  void _increase() {
    setState(() {
      _count = _count + 1;
    });
    _cartBloc.dispatch(ChangeDistQuantityInCart(cartDish.dishId, _count));
  }

  void _decrease() {
    setState(() {
      _count = _count == 1 ? _count : _count - 1;
    });
    _cartBloc.dispatch(ChangeDistQuantityInCart(cartDish.dishId, _count));
  }

  @override
  Widget build(BuildContext context) {
    _cartItemBloc.state.listen((state) {
      if (state is CartItemInitialize) {
        _cartItemBloc.dispatch(FetchCartItemDetail(cartDish));
      }
    });
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            child: BlocBuilder(
              bloc: _cartItemBloc,
              builder: (BuildContext context, state) {
                if (state is CartItemFetchedCartDishDetail)
                  return Image.network(
                    state.dailyDish.dish.images[0],
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  );
                else if (state is CartItemToFetchDetailNotSellToDay) {
                  _cartBloc.dispatch(RemoveDishFromCart(cartDish.dishId));
                }
                return Image.asset(
                  'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                );
              },
            ),
          ),
          BlocBuilder(
            bloc: _cartItemBloc,
            builder: (BuildContext context, state) {
              if (state is CartItemFetchedCartDishDetail) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        state.dailyDish.dish.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('${cartDish.price} VNĐ'),
                  ],
                );
              } else if (state is CartItemToFetchDetailNotSellToDay) {
                _cartBloc.dispatch(RemoveDishFromCart(cartDish.dishId));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      'Đang tải...',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${cartDish.price} VNĐ'),
                ],
              );
            },
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 60,
                child: FlatButton(
                  color: Colors.white,
                  splashColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: primaryColor,
                  ),
                  onPressed: _increase,
                ),
              ),
              SizedBox(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Text(_count.toString()),
                    ],
                  )),
              SizedBox(
                height: 25,
                width: 60,
                child: FlatButton(
                  color: Colors.white,
                  splashColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryColor,
                  ),
                  onPressed: _decrease,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
