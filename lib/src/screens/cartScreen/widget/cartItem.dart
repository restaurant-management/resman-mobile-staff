import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/FakeData.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';

class CartItem extends StatefulWidget {
  final CartDishModel cartDish;

  const CartItem({Key key, @required this.cartDish})
      : assert(cartDish != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
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
  }

  void _decrease() {
    setState(() {
      _count = _count == 1 ? _count : _count - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              child: Image.network(
                FakeData.dailyDish.dish.images[0],
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    FakeData.dailyDish.dish.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('${FakeData.dailyDish.dish.defaultPrice.toString()}'),
              ],
            ),
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
