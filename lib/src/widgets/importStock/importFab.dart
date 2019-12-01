import 'package:flutter/material.dart';

class ImportFab extends StatefulWidget {
  @override
  _ImportFabState createState() => _ImportFabState();
}

class _ImportFabState extends State<ImportFab>
    with SingleTickerProviderStateMixin {
  bool _isOpened = false;
  AnimationController _animationController;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!_isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      _isOpened = !_isOpened;
    });
  }

  Widget makeImportBill(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AnimatedOpacity(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.onSecondary,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                color: colorScheme.primaryVariant),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                'Tạo hóa đơn nhập',
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
          ),
          opacity: _isOpened ? 1 : 0,
          duration: Duration(milliseconds: 500),
        ),
        SizedBox(
          width: 4,
        ),
        FloatingActionButton(
          heroTag: 'importBill',
          child: Icon(
            Icons.save_alt,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          onPressed: animate,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primaryVariant,
              width: 0.5,
              style: BorderStyle.solid,
            ),
          ),
          elevation: 0,
        ),
      ],
    );
  }

  Widget makeDailyReport(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AnimatedOpacity(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.onSecondary,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                color:  colorScheme.secondaryVariant),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                'Tạo báo cáo hằng ngày',
                style: TextStyle(color: colorScheme.onSecondary),
              ),
            ),
          ),
          opacity: _isOpened ? 1 : 0,
          duration: Duration(milliseconds: 500),
        ),
        SizedBox(
          width: 4,
        ),
        FloatingActionButton(
          heroTag: 'dailyReport',
          child: Icon(
            Icons.receipt,
            size: 20,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
          onPressed: animate,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
              width: 0.5,
              style: BorderStyle.solid,
            ),
          ),
          elevation: 0,
        ),
      ],
    );
  }

  Widget toggle(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'main',
      child: Icon(
        _isOpened ? Icons.close : Icons.add,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      backgroundColor: Color.fromRGBO(44, 101, 250, 0.97),
      onPressed: animate,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(90),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSecondary,
          width: 0.5,
          style: BorderStyle.solid,
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          child: makeImportBill(context),
          transform:
              Matrix4.translationValues(0, _translateButton.value * 2, 0),
        ),
        Transform(
          child: makeDailyReport(context),
          transform: Matrix4.translationValues(0, _translateButton.value, 0),
        ),
        toggle(context)
      ],
    );
  }
}
