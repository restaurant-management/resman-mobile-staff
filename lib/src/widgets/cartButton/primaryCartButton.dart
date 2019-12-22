import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/state.dart';

class PrimaryCartButton extends StatefulWidget {
  final Color color;

  const PrimaryCartButton({Key key, this.color}) : super(key: key);

  @override
  _PrimaryCartButtonState createState() => _PrimaryCartButtonState();
}

class _PrimaryCartButtonState extends State<PrimaryCartButton> {
  int _count = 0;

  final CartBloc _cartBloc = CartBloc();

  @override
  void initState() {
    _count = _cartBloc.currentCart.listDishes.length;
    super.initState();
  }

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
          badgeContent: SizedBox(
            width: 12,
            height: 12,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _count.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          position: BadgePosition.topRight(top: 5.0, right: 5.0),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: widget.color != null
                  ? widget.color
                  : Theme.of(context).colorScheme.onPrimary,
            ), onPressed: () {},
          ),
        ),
      ),
    );
  }
}
