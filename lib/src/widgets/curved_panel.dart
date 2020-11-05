import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CurvedPanel extends StatelessWidget {
  final Widget child;

  const CurvedPanel({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        color: kPrimaryColor,
      ),
      child: child,
    );
  }
}
