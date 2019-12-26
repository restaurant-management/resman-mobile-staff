import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final double loadingIconSize;
  final double widthTurnOnIcon;

  LoadingButton(
      {Key key,
      this.onPressed,
      this.child,
      this.width,
      this.height,
      this.color,
      this.loadingIconSize,
      this.widthTurnOnIcon})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoadingButtonState();
  }
}

class LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  VoidCallback get onPressed => widget.onPressed;

  Widget get title => widget.child;

  double get width => widget.width;

  double get height => widget.height;

  Color get color => widget.color;

  double get loadingIconSize => widget.loadingIconSize;

  double get widthTurnOnIcon => widget.widthTurnOnIcon;

  AnimationController _buttonController;
  Animation _buttonSqueezeAnimation;

  @override
  void initState() {
    super.initState();
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          onPressed?.call();
        }
      });
    _buttonSqueezeAnimation = new Tween(
      begin: width != null ? width : 320.0,
      end: 70.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: new Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: _buttonController,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: color != null ? color : Theme.of(context).primaryColor,
        child: SizedBox(
          width: _buttonSqueezeAnimation.value,
          height: height != null ? height : 60.0,
          child: MaterialButton(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              onPressed: () {
                _playAnimation();
              },
              child: _buttonSqueezeAnimation.value >
                      (widthTurnOnIcon != null ? widthTurnOnIcon : 75.0)
                  ? title != null ? title : Container()
                  : SizedBox(
                      height: loadingIconSize != null ? loadingIconSize : 30,
                      width: loadingIconSize != null ? loadingIconSize : 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ))),
        ));
  }

  loadingComplete() {
    _buttonController.reverse();
  }
}
