import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../services/lol_service.dart';
import '../models/champion.dart';
import '../models/skin.dart';
import '../theme/colors.dart';
import '../widgets/text_loading.dart';
import '../widgets/curved_panel.dart';
import '../theme/text_styles.dart';

enum ChildType {
  Info,
  Passive,
  Q,
  W,
  E,
  R,
}

class ChampionDetailsScreen extends StatefulWidget {
  final String championId;

  const ChampionDetailsScreen({Key key, @required this.championId})
      : assert(championId != null),
        super(key: key);

  @override
  _ChampionDetailsScreenState createState() => _ChampionDetailsScreenState();
}

class _ChampionDetailsScreenState extends State<ChampionDetailsScreen> {
  ChildType _childType;

  @override
  void initState() {
    super.initState();

    _childType = ChildType.Info;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Champion>(
        future: LolService.instance.getChampion(widget.championId),
        builder: (_, snapshot) => (!snapshot.hasData)
            ? _buildLoading()
            : Stack(
                fit: StackFit.expand,
                children: [
                  _buildBackground(snapshot.data.skins),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildChampionInfo(snapshot.data),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Container(color: kAccentColor),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CurvedPanel(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    final totalWidth = constraints.maxWidth;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLoading(width: totalWidth * 0.2),
                        const SizedBox(height: 8.0),
                        TextLoading(width: totalWidth * 0.4),
                        const SizedBox(height: 32.0),
                        TextLoading(width: totalWidth * 0.8),
                        const SizedBox(height: 8.0),
                        TextLoading(width: totalWidth * 0.9),
                        const SizedBox(height: 8.0),
                        TextLoading(width: totalWidth * 0.7),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildBackground(List<Skin> skins) => CachedNetworkImage(
        imageUrl: skins.first.url,
        fit: BoxFit.cover,
      );

  Widget _buildChampionInfo(Champion champion) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButtons(),
          const SizedBox(height: 16.0),
          CurvedPanel(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _getCurrentChild(_childType, champion),
            ),
          ),
        ],
      );

  Widget _buildButtons() => Row(
        children: [],
      );

  Widget _getCurrentChild(ChildType type, Champion champion) {
    switch (type) {
      case ChildType.Info:
        return _buildInfo(champion);
      default:
        return Container(
          color: Colors.red,
          height: 250,
        );
    }
  }

  Widget _buildInfo(Champion champion) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(champion.name, style: kBold16),
          const SizedBox(height: 8.0),
          Text(champion.title),
          const SizedBox(height: 32.0),
          Text(champion.lore, style: kLight),
        ],
      );
}
