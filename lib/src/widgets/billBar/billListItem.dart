import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resman_mobile_staff/src/models/billDishModel.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';

class BillListItem extends StatefulWidget {
  final BillDishModel billDish;
  final int count;
  final Function onpressed;
  final IconData icon;

  BillListItem({Key key, this.billDish, this.count, this.onpressed, this.icon})
      : super(key: key);

  _BillListItemState createState() => _BillListItemState();
}

class _BillListItemState extends State<BillListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(const Radius.circular(90)),
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                "${widget.count}",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )),
        title: Text(
          widget.billDish.dish.name,
        ),
        subtitle: Text(widget.billDish.note),
        trailing: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(const Radius.circular(90)),
              color: Colors.transparent,
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: FlatButton(
            child: Center(
              child: Icon(widget.icon),
            ),
            // child: Icon(widget.icon),
            color: Colors.transparent,
            onPressed: widget.onpressed,
            padding: EdgeInsets.all(10.0),
          ),
        ));
  }
}
