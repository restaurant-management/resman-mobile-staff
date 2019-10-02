import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../widgets/loadingButton.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  final Key loadingKey;

  LoginButton(
      {Key key,
      this.onPressed,
      @required this.text,
      this.color,
      this.loadingKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      key: loadingKey,
      height: 50,
      width: MediaQuery.of(context).size.width,
      widthTurnOnIcon: 120,
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
