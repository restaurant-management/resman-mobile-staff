import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:toast/toast.dart';

class DishItemStaff extends StatefulWidget {
  final int billId;
  final BillDishModel billDishModel;
  final double cardHeight;

  const DishItemStaff(
      {Key key, @required this.billDishModel, this.cardHeight = 80, @required this.billId})
      : assert(billDishModel != null),
        super(key: key);

  @override
  _DishItemStaffState createState() => _DishItemStaffState();
}

class _DishItemStaffState extends State<DishItemStaff> {
  Repository _repository = Repository();

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
              widget.billDishModel.dish.images[0],
              fit: BoxFit.cover,
              width: widget.cardHeight,
              height: widget.cardHeight,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              height: widget.cardHeight * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      widget.billDishModel.dish.name,
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
                    'Số lượng: ' + widget.billDishModel.quantity.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Text('${widget.billDishModel.note.toString()}'),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          _mapStateToButton(widget.billDishModel, context)
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
              color: colors.colorScheme.onPrimary,
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
            onPressed: () {
              setState(() {
                billDishModel.deliveryAt = DateTime.now();
              });
              _repository.deliveredBillDish(widget.billId, billDishModel.dish.dishId).catchError((e){
                Toast.show(e, context);
              });
            },
            child: Icon(
              Icons.arrow_forward,
              color: colors.colorScheme.onPrimary,
            ),
            color: colors.colorScheme.secondary,
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
          padding: EdgeInsets.zero,
          borderRadius: new BorderRadius.circular(30.0),
          onPressed: () {},
          child: Icon(
            Icons.more_horiz,
            color: colors.colorScheme.onPrimary,
          ),
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
