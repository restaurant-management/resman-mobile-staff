import 'package:flutter/widgets.dart';

class ImageBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/login-background.jpg",
      fit: BoxFit.fill,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
