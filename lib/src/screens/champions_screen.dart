import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
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
          (i) => _buildChampionItem(champions[i]),
        ),
      );

  Widget _buildChampionItem(Champion champion) => Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              champion.avatar,
            ),
          ),
        ),
      );
}
