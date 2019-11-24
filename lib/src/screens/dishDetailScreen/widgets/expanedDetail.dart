import 'package:flutter/material.dart';

class ExpandedDetail extends StatefulWidget {
  final Widget child;
  final String title;
  final bool expand;

  const ExpandedDetail({Key key, this.expand = false, this.child, @required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ExpandedDetailState(child, expand, title);
}

class ExpandedDetailState extends State<ExpandedDetail> {
  final Widget child;
  final bool expand;
  final String title;

  bool expanded;

  ExpandedDetailState(this.child, this.expand, this.title);

  @override
  void initState() {
    expanded = expand;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MaterialButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Icon(
                !expanded ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              expanded = !expanded;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ExpandedSection(
            child: child,
            expand: expanded,
          ),
        ),
      ],
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;

  ExpandedSection({this.expand = false, this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    Animation curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    if(widget.expand) expandController.forward();
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
