import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CurvedPanel extends StatefulWidget {
  final Widget child;

  const CurvedPanel({Key key, this.child}) : super(key: key);

  @override
  _CurvedPanelState createState() => _CurvedPanelState();
}

class _CurvedPanelState extends State<CurvedPanel>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        color: kPrimaryColor,
      ),
      child: AnimatedSize(
        vsync: this,
        alignment: Alignment.centerLeft,
        duration: Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}
