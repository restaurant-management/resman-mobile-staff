import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';

class AnimationLogo extends StatefulWidget {
  final VoidCallback onAnimationCompleted;
  final int animationTime;

  const AnimationLogo(
      {Key key, this.onAnimationCompleted, this.animationTime = 2000})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnimationLogoState();
  }
}

class AnimationLogoState extends State<AnimationLogo>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: widget.animationTime), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          widget.onAnimationCompleted?.call();
        }
      });
    _playAnimation();
  }

  Future<void> _playAnimation() async {
    await new Future.delayed(Duration(seconds: 1));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(
        animation: animation,
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 150);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Image.asset(
        'assets/images/logo.png',
        height: _sizeTween.evaluate(animation),
        fit: BoxFit.fill,
      ),
    );
  }
}
