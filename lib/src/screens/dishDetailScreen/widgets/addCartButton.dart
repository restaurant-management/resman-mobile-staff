import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/utils/gradientColor.dart';

class AddCartButton extends StatefulWidget {
  final DailyDishModel dailyDish;

  const AddCartButton({Key key, @required this.dailyDish})
      : assert(dailyDish != null),
        super(key: key);

  @override
  _AddCartButtonState createState() => _AddCartButtonState();
}

class _AddCartButtonState extends State<AddCartButton> {
  bool isCreating = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CartBloc().add(AddDishIntoCart(widget.dailyDish));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            gradient: GradientColor.of(context).primaryLinearGradient),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isCreating
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )
                : Icon(
                    Icons.add_shopping_cart,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Thêm vào hoá đơn',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
