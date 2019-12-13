import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/event.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/dishModel.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';
import 'package:resman_mobile_staff/src/screens/dishDetailScreen/dishDetailScreen.dart';

class DishItemCard extends StatefulWidget {
  final DailyDishModel dailyDish;
  final DishModal dish;
  final String buttonText;

  const DishItemCard({Key key, this.dailyDish, this.dish, this.buttonText})
      : super(key: key);

  @override
  _DishItemCardState createState() => _DishItemCardState();
}

class _DishItemCardState extends State<DishItemCard> {
  Repository _repository = new Repository();
  String note;
  final noteTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    noteTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size contextSize = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => DishDetailScreen(
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
                  image: widget.dailyDish.dish.images.length > 0
                      ? widget.dailyDish.dish.images[0] ?? ''
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
                      widget.dailyDish.dish.name ?? "Chưa cập nhật",
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
                            '${widget.dailyDish.dish.defaultPrice ?? 0}',
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
                onPressed: () {
                  _showNote();
                  CartBloc().dispatch(AddDishIntoCart(widget.dailyDish));
                },
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
                      widget.buttonText ?? 'Thêm',
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

  void _showNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Ghi chú"),
          content: TextField(
            controller: noteTextFieldController,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Nhập ghi chú..."),
          ),
          actions: <Widget>[
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).primaryColor,
              child: new Text(
                "Bỏ qua",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              onPressed: () {
                note = noteTextFieldController.text ?? "";
                Navigator.of(context).pop();
              },
            ),
            new CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minSize: 20,
              color: Theme.of(context).primaryColor,
              child: new Text(
                "Xác nhận",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              onPressed: () {
                note = "";
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
