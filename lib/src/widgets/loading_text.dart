import 'package:flutter/material.dart';

import '../theme/colors.dart';

class LoadingText extends StatelessWidget {
  final double width;

  const LoadingText({Key key, this.width = 64.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 24.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: kSecondaryColor,
      ),
    );
  }
}
