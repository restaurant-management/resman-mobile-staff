import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';

class DishItemChef extends StatelessWidget {
  final BillDishModel billDishModel;

  const DishItemChef({Key key, @required this.billDishModel})
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  billDishModel.dish.name,
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
              Text('${billDishModel.note.toString()}'),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                    width: 30,
                    child: Center(
                      child: Text(
                        'SL: ',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    width: 50,
                    child: Row(
                      children: <Widget>[
                        Text(billDishModel.quantity.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
                width: 80,
                child: FlatButton(
                  color: Colors.white,
                  splashColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: primaryColor,
                  ), onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
