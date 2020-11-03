import 'package:flutter/material.dart';

import './src/screens/champions_screen.dart';
import './src/theme/colors.dart';
import './src/services/lol_service.dart';

void main() async {
  await LolService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lol Champs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'WorkSans',
        scaffoldBackgroundColor: Colors.white,
        accentColor: kAccentColor,
        // primaryColor: kAccentColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kAccentColor,
              displayColor: kAccentColor,
            ),
      ),
      home: ChampionsScreen(),
    );
  }
}
