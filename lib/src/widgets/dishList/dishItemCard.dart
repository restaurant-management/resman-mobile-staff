import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:restaurant_management_mobile/src/blocs/cartBloc/bloc.dart';
//import 'package:restaurant_management_mobile/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';
import 'package:resman_mobile_staff/src/screens/dishDetailScreen/dishDetailScreen.dart';

class DishItemCard extends StatelessWidget {
  final DailyDishModel dailyDish;
  final DishModal dish;
  final String buttonText;

  const DishItemCard({Key key, this.dailyDish, this.dish, this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size contextSize = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => DishDetailScreen(dailyDish: dailyDish,),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                  image: dailyDish.dish.images.length > 0
                      ? dailyDish.dish.images[0] ?? ''
                      : '',
                  width: contextSize.width / 2.2,
                  height: contextSize.width / 2,
                ),
              ),
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
                      dailyDish.dish.name ?? "Chưa cập nhật",
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
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${dailyDish.dish.defaultPrice ?? 0} VNĐ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
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
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      buttonText ?? 'Thêm',
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
