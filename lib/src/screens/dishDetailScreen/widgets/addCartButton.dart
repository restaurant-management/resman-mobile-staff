import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';

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
    return MaterialButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {},
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isCreating
                ? CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
                : Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Thêm vào hoá đơn',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
    );
  }
}
