import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/repositories/reponsitory.dart';
import 'package:toast/toast.dart';

class DishItemChef extends StatefulWidget {
  final int billId;
  final BillDishModel billDishModel;

  const DishItemChef({Key key, @required this.billDishModel, this.billId})
      : assert(billDishModel != null),
        super(key: key);

  @override
  _DishItemChefState createState() => _DishItemChefState();
}

class _DishItemChefState extends State<DishItemChef> {
  bool isChecked = false;
  Repository _repository = Repository();

  @override
  void initState() {
    if (widget.billDishModel.preparedAt != null) isChecked = true;
    super.initState();
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
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            child: Image.network(
              widget.billDishModel.dish.images[0],
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
                Text('${widget.billDishModel.note.toString()}'),
                Text(' Số lượng: ${widget.billDishModel.quantity ?? 0}'),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              CupertinoButton(
                child: Icon(
                  Icons.check,
                  color: isChecked ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                  _repository
                      .prepareBillDish(
                          widget.billId, widget.billDishModel.dish.dishId)
                      .catchError((e) {
                    setState(() {
                      isChecked = false;
                    });
                    Toast.show(e, context);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
