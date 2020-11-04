import 'package:flutter/material.dart';

import '../widgets/champions_grid_item.dart';
import '../services/lol_service.dart';
import '../models/champion.dart';

class ChampionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Champion>>(
          future: LolService.instance.getChampions(),
          builder: (_, snapshot) => (!snapshot.hasData)
              ? Center(child: CircularProgressIndicator())
              : _buildChampionsGrid(snapshot.data),
        ),
      ),
    );
  }

  Widget _buildChampionsGrid(List<Champion> champions) => GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        padding: EdgeInsets.all(24.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: List.generate(
          champions.length,
          (i) => ChampionsGridItem(champion: champions[i]),
        ),
      );
}
