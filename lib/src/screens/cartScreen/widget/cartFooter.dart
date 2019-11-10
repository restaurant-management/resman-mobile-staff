import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'sumaryBill.dart';

class CartFooter extends StatefulWidget {
  final double height;
  final bool hasCreateButton;

  const CartFooter(
      {Key key, @required this.height, this.hasCreateButton = true})
      : super(key: key);

  @override
  _CartFooterState createState() => _CartFooterState();
}

class _CartFooterState extends State<CartFooter> {
  bool _isCreating = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SummaryBill(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GradientButton(
                increaseWidthBy: 100,
                increaseHeightBy: MediaQuery.of(context).size.height * 0.01,
                child: Text('Tạo hoá đơn'),
                gradient: LinearGradient(
                  colors: <Color>[
                    !_isCreating
                        ? const Color.fromRGBO(88, 39, 176, 1)
                        : const Color.fromRGBO(0, 0, 0, 0.5),
                    !_isCreating
                        ? const Color.fromRGBO(0, 39, 176, 1)
                        : const Color.fromRGBO(0, 0, 0, 0.5),
                  ],
                  stops: [0.1, 1.0],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
