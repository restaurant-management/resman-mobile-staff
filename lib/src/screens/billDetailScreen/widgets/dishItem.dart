import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';

class DishItem extends StatelessWidget {
  final BillDishModel billDishModel;

  const DishItem({Key key, @required this.billDishModel})
      : assert(billDishModel != null),
        super(key: key);

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
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            child: Image.network(
              billDishModel.dish.images[0],
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
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
                    billDishModel.dish.name ?? 'Chưa cập nhật',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
                Text('${billDishModel.note ?? ""}'),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 80,
                child: Center(
                    child: Text(
                  'Số lượng',
                  style: TextStyle(color: primaryColor),
                )),
              ),
              SizedBox(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Text(billDishModel.quantity.toString()),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
