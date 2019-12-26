import 'package:flutter/material.dart';

class MapFab extends StatefulWidget {
  @override
  _MapFabState createState() => _MapFabState();
}

class _MapFabState extends State<MapFab> with SingleTickerProviderStateMixin {
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

  Widget takePhoto(BuildContext context) {
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
                color: Color.fromRGBO(255, 255, 255, 0.97)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text('Take photo from camera and share'),
            ),
          ),
          opacity: _isOpened ? 1 : 0,
          duration: Duration(milliseconds: 500),
        ),
        SizedBox(
          width: 4,
        ),
        FloatingActionButton(
          heroTag: 'sub',
          child: Icon(
            Icons.camera_alt,
            color: Theme.of(context).colorScheme.surface,
          ),
          backgroundColor: Color(0xff56CCF2),
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

  Widget fromGallery(BuildContext context) {
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
                color: Color.fromRGBO(255, 255, 255, 0.97)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text('Share photos from gallery'),
            ),
          ),
          opacity: _isOpened ? 1 : 0,
          duration: Duration(milliseconds: 500),
        ),
        SizedBox(
          width: 4,
        ),
        FloatingActionButton(
          heroTag: 'sub2',
          child: Icon(
            Icons.check,
          ),
          backgroundColor: Color(0xff6FCF97),
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
        _isOpened ? Icons.close : Icons.camera_alt,
        color: Theme.of(context).colorScheme.surface,
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
          child: takePhoto(context),
          transform:
              Matrix4.translationValues(0, _translateButton.value * 2, 0),
        ),
        Transform(
          child: fromGallery(context),
          transform: Matrix4.translationValues(0, _translateButton.value, 0),
        ),
        toggle(context)
      ],
    );
  }
}
