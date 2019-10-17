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
    // return Container(
    //    child: Row(
    //      children: <Widget>[
    //        Container(
    //          width: MediaQuery.of(context).size.width,
    //         decoration: BoxDecoration(
    //            borderRadius: const BorderRadius.all(const Radius.circular(90)),
    //            color: Colors.grey
    //          ),
    //          child: Text(
    //            "${widget.count}"
    //          ),
    //        ),
    //        Container(
    //          child: Column(
    //            children: <Widget>[
    //              Text(
    //                '${widget.billDish.dish.name}',
    //                textAlign: TextAlign.left,
    //                overflow: TextOverflow.fade,
    //              ),
    //               Text(
    //                 '${widget.billDish.note}',
    //                 textAlign: TextAlign.left,
    //                 overflow: TextOverflow.clip,
    //                 style: TextStyle(fontWeight: FontWeight.bold),
    //               )
    //            ],
    //          ),
    //        ),
    //        FlatButton(
    //          color: Theme.of(context).primaryColor,
    //          splashColor: Theme.of(context).primaryColorLight,
    //          child: Icon(
    //             Icons.done,
    //             color: Colors.white,
    //          ),
    //          onPressed: widget.onpressed,
    //        )
    //      ],
    //    ),
    // );
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
            ),
          ),
        )
      ),
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
          border: Border.all(color: Theme.of(context).primaryColor)
        ),
        child: FlatButton(
          child: Center(
            child: Icon(widget.icon),
            ),
          // child: Icon(widget.icon),
          color: Colors.transparent,
          onPressed: widget.onpressed,
          padding: EdgeInsets.all(10.0),
        ),
      )
      
    );
  }
}
