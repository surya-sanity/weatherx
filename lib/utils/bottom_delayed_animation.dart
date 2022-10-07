import 'package:flutter/material.dart';

class BottomDelayedAnimation extends StatefulWidget {
  final Widget child;
  final Duration delayDuration;
  final Curve curve;
  final Duration animationDuration;
  BottomDelayedAnimation({
    @required this.child,
    @required this.delayDuration,
    @required this.animationDuration,
    @required this.curve,
  });
  @override
  _BottomDelayedAnimationState createState() => _BottomDelayedAnimationState();
}

class _BottomDelayedAnimationState extends State<BottomDelayedAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween(begin: Offset(0, 5), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
    Future.delayed(widget.delayDuration).then((value) => _controller.forward());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
