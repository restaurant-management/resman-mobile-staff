import 'package:flutter/widgets.dart';

class OutlineText extends StatelessWidget{
  final Color color;
  final String text;

  const OutlineText({Key key, this.color, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(shadows: [
        Shadow(
          // bottomLeft
          offset: Offset(-1.5, -1.5),
          color: color,
        ),
        Shadow(
          // bottomRight
          offset: Offset(1.5, -1.5),
          color: color,
        ),
        Shadow(
          // topRight
          offset: Offset(1.5, 1.5),
          color: color,
        ),
        Shadow(
          // topLeft
          offset: Offset(-1.5, 1.5),
          color: color,
        ),
      ]),
    );
  }
}