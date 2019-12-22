import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/state.dart';

class SecondaryCartButton extends StatefulWidget {
  final Color color;

  const SecondaryCartButton({Key key, this.color}) : super(key: key);

  @override
  _SecondaryCartButtonState createState() => _SecondaryCartButtonState();
}

class _SecondaryCartButtonState extends State<SecondaryCartButton> {
  int _count = 0;

  // ignore: close_sinks
  final CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cartBloc,
      listener: (BuildContext context, state) {
        if (state is CartBlocSaved ||
            state is CartBlocFetched ||
            state is CartBlocCreatedBill) {
          int totalDishes = 0;
          _cartBloc.currentCart.listDishes.forEach((dish) {
            totalDishes += dish.quantity;
          });
          setState(() {
            _count = totalDishes;
          });
        }
      },
      child: InkWell(
        onTap: () {
          Scaffold.of(context).openEndDrawer();
        },
        child: Badge(
          position: BadgePosition.topRight(top: 7.0, right: 7.0),
          badgeContent: SizedBox(
            width: 10,
            height: 10,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _count.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          child: FloatingActionButton(
            elevation: 10,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.shopping_cart,
              color: widget.color != null ? widget.color : Colors.white,
            ), onPressed: () {},
          ),
        ),
      ),
    );
  }
}
