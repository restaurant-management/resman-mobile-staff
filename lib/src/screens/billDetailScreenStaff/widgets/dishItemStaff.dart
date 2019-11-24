import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';

class DishItemStaff extends StatelessWidget {
  final BillDishModel billDishModel;

  const DishItemStaff({Key key, @required this.billDishModel})
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
                    billDishModel.dish.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Số lượng: ' + billDishModel.quantity.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
                Text('${billDishModel.note.toString()}'),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          _mapStateToButton(billDishModel, context)
        ],
      ),
    );
  }

  Widget _mapStateToButton(BillDishModel billDishModel, BuildContext context) {
    final colors = Theme.of(context);
    final btnSize = 40.0;
    if (billDishModel.deliveryAt != null)
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          color: Colors.transparent,
          width: btnSize,
          height: btnSize,
          child: CupertinoButton(
            padding: const EdgeInsets.all(0),
            borderRadius: new BorderRadius.circular(30.0),
            onPressed: () {},
            child: Icon(
              Icons.check,
              size: btnSize * 0.8,
              color: colors.colorScheme.onSurface,
            ),
            color: Colors.greenAccent,
          ),
        ),
      );
    if (billDishModel.preparedAt != null)
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          color: Colors.transparent,
          width: btnSize,
          height: btnSize,
          child: CupertinoButton(
            padding: const EdgeInsets.all(0),
            borderRadius: new BorderRadius.circular(30.0),
            onPressed: () {},
            child: Icon(
              Icons.arrow_forward,
              color: colors.colorScheme.onSurface,
            ),
            color: colors.primaryColor,
          ),
        ),
      );
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        color: Colors.transparent,
        width: btnSize,
        height: btnSize,
        child: CupertinoButton(
          padding: const EdgeInsets.all(0),
          borderRadius: new BorderRadius.circular(30.0),
          onPressed: () {},
          child: Icon(
            Icons.more_horiz,
            color: colors.colorScheme.onSurface,
          ),
          color: Colors.grey,
        ),
      ),
    );
  }
}
