import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/screens/dishDetailScreen/dishDetailScreen.dart';

class DishItemCard extends StatefulWidget {
  final DailyDishModel dailyDish;

  const DishItemCard({Key key, this.dailyDish}) : super(key: key);

  @override
  _DishItemCardState createState() => _DishItemCardState();
}

class _DishItemCardState extends State<DishItemCard> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final Size contextSize = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    final price = widget.dailyDish.dish.price ?? 0;
    final defaultPrice = widget.dailyDish.dish.defaultPrice ?? 0;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DishDetailScreen(
              dailyDish: widget.dailyDish,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                  image: widget.dailyDish.dish.images.length > 0
                      ? widget.dailyDish.dish.images[0] ?? ''
                      : '',
                  height: contextSize.width / 2,
                ),
              ),
              widget.dailyDish.dish.price > 0 &&
                      widget.dailyDish.dish.price -
                              widget.dailyDish.dish.defaultPrice <
                          0 &&
                      widget.dailyDish.dish.defaultPrice != 0
                  ? _buildDiscount(
                      discount: ((widget.dailyDish.dish.price -
                                  widget.dailyDish.dish.defaultPrice) *
                              100 /
                              widget.dailyDish.dish.defaultPrice)
                          .round()
                          .toString())
                  : Container(),
            ]),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    width: contextSize.width / 2.4,
                    child: Text(
                      widget.dailyDish.dish.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: contextSize.width / 2.4,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            price != null && price > 0 && price < defaultPrice
                                ? '$price VNĐ'
                                : '$defaultPrice VNĐ',
                            style: Theme.of(context).textTheme.body1,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          price != null && price > 0 && price < defaultPrice
                              ? Text(
                                  '$defaultPrice VNĐ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 1,
              width: contextSize.width / 2.2,
              child: Container(
                color: primaryColor,
              ),
            ),
            SizedBox(
              width: contextSize.width / 2.2,
              height: 40,
              child: FlatButton(
                color: Colors.white,
                splashColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                onPressed: _loading
                    ? null
                    : () {
                        CartBloc().add(AddDishIntoCart(widget.dailyDish));
                        setState(() {
                          _loading = true;
                          Future.delayed(Duration(seconds: 1)).then((_) {
                            setState(() {
                              _loading = false;
                            });
                          });
                        });
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: _loading
                          ? CircularProgressIndicator(
                              strokeWidth: 1,
                            )
                          : Icon(
                              Icons.add_shopping_cart,
                              color: primaryColor,
                            ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Thêm',
                      style: TextStyle(color: primaryColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDiscount({String discount = ''}) {
    return discount != ''
        ? Positioned(
            right: 5,
            top: 5,
            width: 40,
            height: 40,
            child: Stack(children: <Widget>[
              Image.asset(
                'assets/icons/sticker.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(
                  '$discount%',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
          )
        : SizedBox();
  }
}
