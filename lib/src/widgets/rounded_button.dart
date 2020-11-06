import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  final Widget child;
  final double animationBegin;
  final Duration duration;
  final Curve curve;
  final VoidCallback onTap;

  const RoundedButton({
    Key key,
    this.child,
    this.animationBegin = 0.9,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.linear,
    this.onTap,
  })  : assert(animationBegin <= 1.0 && animationBegin >= 0.0),
        super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: widget.animationBegin, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: widget.curve),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) => Transform.scale(
        scale: _animation.value,
        child: child,
      ),
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: widget.child,
        ),
        onTapDown: (widget.onTap == null)
            ? null
            : (_) => _animationController.reverse(),
        onLongPressEnd: (widget.onTap == null)
            ? null
            : (_) => _animationController.forward(),
        onTap: (widget.onTap == null)
            ? null
            : () => _animationController.reverse().then(
                  (_) {
                    widget.onTap?.call();
                    _animationController.forward();
                  },
                ),
      ),
    );
  }
}
