import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';
import 'package:resman_mobile_staff/src/screens/billDetailScreen/billDetailScreen.dart';

class DishListItem extends StatefulWidget {
  final DishModal dish;
  final Function onPressed;
  final String note;

  DishListItem({Key key, this.dish, this.onPressed, this.note})
      : super(key: key);

  _DishListItemState createState() => _DishListItemState();
}

class _DishListItemState extends State<DishListItem> {
  DishModal get dishItem => widget.dish;

  String get note => widget.note;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BillDetailScreen()));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(0),
                    color: Color.fromRGBO(88, 37, 176, 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(0),
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Ten',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(dishItem.name.toString())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 1,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Ghi chu',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(note)
                      ],
                    ),
                  ),
                ],
              ),
              _buildButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return _buildButtonWidget('Xác nhận chuẩn bị xong',
        increaseWidthBy: 90, onPressed: () {});
  }

  Widget _buildButtonWidget(String text,
      {VoidCallback onPressed, double increaseWidthBy = 60}) {
    bool isUpdating = true;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GradientButton(
          child: Text(text),
          increaseWidthBy: increaseWidthBy,
          callback: onPressed,
          gradient: LinearGradient(
            colors: <Color>[
              !isUpdating
                  ? Color.fromRGBO(88, 150, 176, 1)
                  : Color.fromRGBO(0, 0, 0, 0.3),
              !isUpdating
                  ? Color.fromRGBO(88, 39, 176, 1)
                  : Color.fromRGBO(0, 0, 0, 0.3),
            ],
            stops: [0.1, 1.0],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
      ],
    );
  }
}
