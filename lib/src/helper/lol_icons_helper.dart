import 'package:flutter/material.dart' show IconData;

import '../models/role.dart';
import '../theme/lol_icons.dart';

class LolIconsHelper {
  static IconData getRoleIcon(Role role) {
    IconData icon;

    switch (role) {
      case Role.Assassin:
        icon = LolIcons.assassin_role;
        break;
      case Role.Fighter:
        icon = LolIcons.fighter_role;
        break;
      case Role.Mage:
        icon = LolIcons.mage_role;
        break;
      case Role.Marksman:
        icon = LolIcons.marksman_role;
        break;
      case Role.Support:
        icon = LolIcons.support_role;
        break;
      case Role.Tank:
        icon = LolIcons.tank_role;
        break;
    }

    return icon;
  }
}
