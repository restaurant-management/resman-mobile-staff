import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientColor {
  final BuildContext context;
  final num alphaTopLeft;
  final num alphaCenter;
  final num alphaBottomRight;

  get primaryLinearGradient => LinearGradient(
        colors: [
          Theme.of(context).primaryColor.withAlpha(alphaTopLeft),
          Theme.of(context)
              .colorScheme
              .primaryVariant
              .withAlpha(alphaBottomRight)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  get secondaryLinearGradient => LinearGradient(
        colors: [
          Theme.of(context).primaryColor.withAlpha(alphaTopLeft),
          Theme.of(context)
              .colorScheme
              .primaryVariant
              .withAlpha(alphaBottomRight),
          Colors.black.withAlpha(alphaCenter),
        ],
        stops: [0.1, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  get drawerHeader => LinearGradient(
        colors: <Color>[
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withAlpha(0),
        ],
        stops: [0.1, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  GradientColor.of(this.context,
      {this.alphaTopLeft = 255,
      this.alphaBottomRight = 255,
      this.alphaCenter = 255});
}
