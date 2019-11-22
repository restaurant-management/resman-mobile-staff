import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OutStockHeader extends StatelessWidget {
  final double height;
  final String title;

  const OutStockHeader({Key key, @required this.height, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
        colors: <Color>[
          const Color.fromRGBO(88, 39, 176, 1),
          const Color.fromRGBO(88, 39, 176, 0.5),
          const Color.fromRGBO(255, 255, 255, 0.0),
        ],
        stops: [0.1, 0.5, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title == null ? 'Danh sách món hết hàng' : title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
