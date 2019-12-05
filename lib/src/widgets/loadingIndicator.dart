import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildRandom(context),
    );
  }

  Widget _buildRandom(BuildContext context) {
    int _random = Random().nextInt(3);
    switch (_random) {
      case 0:
        return _buildCircularProgress();
      case 1:
        return _buildLoadingGif(context);
      case 2:
        return _buildLoadingGif2(context);
      default:
        return _buildCircularProgress();
    }
  }

  Widget _buildCircularProgress() {
    return CircularProgressIndicator();
  }

  Widget _buildLoadingGif(BuildContext context) {
    return Image.asset(
      'assets/icons/loading.gif',
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width * 0.2,
    );
  }

  Widget _buildLoadingGif2(BuildContext context) {
    return Image.asset(
      'assets/icons/loading2.gif',
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width * 0.3,
    );
  }
}
