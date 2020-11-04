import 'package:flutter/material.dart';

import '../models/champion.dart';
import '../screens/champion_details_screen.dart';

class ChampionsGridItem extends StatefulWidget {
  final Champion champion;
  final double animationBegin;
  final Duration duration;
  final Curve curve;

  const ChampionsGridItem({
    Key key,
    @required this.champion,
    this.animationBegin = 0.9,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.linear,
  })  : assert(champion != null),
        assert(animationBegin <= 1.0 && animationBegin >= 0.0),
        super(key: key);

  @override
  _ChampionsGridItemState createState() => _ChampionsGridItemState();
}

class _ChampionsGridItemState extends State<ChampionsGridItem>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  Image _championAvatar;

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

    _championAvatar = Image.network(widget.champion.avatar);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: precacheImage(_championAvatar.image, context),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SizedBox();

        _animationController.forward();
        return AnimatedBuilder(
          animation: _animation,
          builder: (_, child) => Transform.scale(
            scale: _animation.value,
            child: child,
          ),
          child: GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: _championAvatar,
            ),
            onTapDown: (_) => _animationController.reverse(),
            onLongPressEnd: (_) => _animationController.forward(),
            onTap: () => _animationController.reverse().then(
              (_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChampionDetailsScreen(),
                  ),
                );

                _animationController.forward();
              },
            ),
          ),
        );
      },
    );
  }
}
