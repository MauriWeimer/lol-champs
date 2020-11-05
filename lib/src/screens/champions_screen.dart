import 'package:flutter/material.dart';

import '../widgets/rounded_button.dart';
import '../services/lol_service.dart';
import '../models/champion.dart';
import '../screens/champion_details_screen.dart';

class ChampionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Champion>>(
          future: LolService.instance.getChampions(),
          builder: (_, snapshot) => (!snapshot.hasData)
              ? Center(child: CircularProgressIndicator())
              : _buildChampionsGrid(context, snapshot.data),
        ),
      ),
    );
  }

  Widget _buildChampionsGrid(BuildContext context, List<Champion> champions) =>
      GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        padding: EdgeInsets.all(24.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: List.generate(
          champions.length,
          (i) => _buildGridItem(context, champions[i]),
        ),
      );

  Widget _buildGridItem(BuildContext context, Champion champion) {
    final championAvatar = Image.network(champion.avatar);

    return FutureBuilder(
      future: precacheImage(championAvatar.image, context),
      builder: (_, snapshot) =>
          (snapshot.connectionState == ConnectionState.waiting)
              ? SizedBox()
              : RoundedButton(
                  child: championAvatar,
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        var begin = Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: ChampionDetailsScreen(
                            championId: champion.id,
                          ),
                        );
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
