import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../services/lol_service.dart';
import '../models/champion.dart';
import '../models/skin.dart';
import '../theme/colors.dart';
import '../widgets/loading_text.dart';
import '../widgets/curved_panel.dart';
import '../theme/text_styles.dart';
import '../theme/lol_icons.dart';
import '../helper/lol_icons_helper.dart';
import '../widgets/rounded_button.dart';

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
    final screenTopPadding = MediaQuery.of(context).padding.top;

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
                  Positioned(
                      top: screenTopPadding + 24.0,
                      left: 24.0,
                      right: 24.0,
                      child: _buildHeader(snapshot.data)),
                ],
              ),
      ),
    );
  }

  Widget _buildHeader(Champion champion) => Row(
        children: [
          RoundedButton(
            child: Container(
              width: 40.0,
              height: 40.0,
              color: kPrimaryColor,
              child: Icon(
                Icons.chevron_left,
                size: 32.0,
                color: kAccentColor,
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
          Spacer(),
          for (var i = 0; i < champion.roles.length; i++) ...[
            RoundedButton(
              child: Container(
                width: 40.0,
                height: 40.0,
                color: kPrimaryColor,
                child: Icon(
                  LolIconsHelper.getRoleIcon(champion.roles[i]),
                  color: kAccentColor,
                ),
              ),
            ),
            if (i < champion.roles.length - 1) const SizedBox(width: 24.0),
          ],
        ],
      );

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
                        LoadingText(width: totalWidth * 0.2),
                        const SizedBox(height: 8.0),
                        LoadingText(width: totalWidth * 0.4),
                        const SizedBox(height: 32.0),
                        LoadingText(width: totalWidth * 0.8),
                        const SizedBox(height: 8.0),
                        LoadingText(width: totalWidth * 0.9),
                        const SizedBox(height: 8.0),
                        LoadingText(width: totalWidth * 0.7),
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
          _buildButtons(champion),
          const SizedBox(height: 24.0),
          CurvedPanel(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: _getCurrentChild(_childType, champion),
            ),
          ),
        ],
      );

  Widget _buildButtons(Champion champion) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildButton(
                Container(
                  color: kPrimaryColor,
                  child: Icon(LolIcons.champion, color: kAccentColor),
                ),
                () => setState(() => _childType = ChildType.Info),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildButton(
                CachedNetworkImage(imageUrl: champion.passive.image),
                () => setState(() => _childType = ChildType.Passive),
              ),
            ),
            const SizedBox(width: 16.0),
            for (var i = 0; i < champion.spells.length; i++) ...[
              Expanded(
                child: _buildButton(
                  CachedNetworkImage(imageUrl: champion.spells[i].image),
                  () => setState(
                    () => _childType = ChildType.values[i + 2],
                  ),
                ),
              ),
              if (i < champion.spells.length - 1) const SizedBox(width: 16.0),
            ],
          ],
        ),
      );

  Widget _buildButton(Widget child, VoidCallback onTap) => AspectRatio(
        aspectRatio: 1.0,
        child: RoundedButton(
          child: child,
          onTap: onTap,
        ),
      );

  Widget _getCurrentChild(ChildType type, Champion champion) {
    Widget currentChild;

    switch (type) {
      case ChildType.Info:
        currentChild = _buildCurrentChild(
          type,
          champion.name,
          champion.title,
          champion.lore,
        );
        break;
      case ChildType.Passive:
        final passive = champion.passive;
        currentChild = _buildCurrentChild(
          type,
          passive.name,
          null,
          passive.description,
        );
        break;
      case ChildType.Q:
        final spell = champion.spells[0];
        currentChild = _buildCurrentChild(
          type,
          spell.name,
          null,
          spell.description,
        );
        break;
      case ChildType.W:
        final spell = champion.spells[1];
        currentChild = _buildCurrentChild(
          type,
          spell.name,
          null,
          spell.description,
        );
        break;
      case ChildType.E:
        final spell = champion.spells[2];
        currentChild = _buildCurrentChild(
          type,
          spell.name,
          null,
          spell.description,
        );
        break;
      case ChildType.R:
        final spell = champion.spells[3];
        currentChild = _buildCurrentChild(
          type,
          spell.name,
          null,
          spell.description,
        );
        break;
    }

    return currentChild;
  }

  Widget _buildCurrentChild(
    ChildType type,
    String title,
    String subtitle,
    String description,
  ) =>
      Column(
        key: ValueKey<ChildType>(type),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kBold16),
          if (subtitle != null) ...[
            const SizedBox(height: 8.0),
            Text(subtitle),
          ],
          const SizedBox(height: 32.0),
          Text(description, style: kLight),
        ],
      );
}
