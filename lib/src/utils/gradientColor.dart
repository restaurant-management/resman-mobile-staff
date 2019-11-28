import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientColor {
  final BuildContext context;

  get primaryLinearGradient => LinearGradient(
    colors: [Theme.of(context).primaryColor, Theme.of(context).colorScheme.primaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  );
  get linearGradient => [Theme.of(context).primaryColor, Theme.of(context).colorScheme.primaryVariant];

  GradientColor.of(this.context);
}