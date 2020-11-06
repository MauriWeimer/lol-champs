import './skin.dart';
import './passive.dart';
import './spell.dart';
import './role.dart';

class Champion {
  final String key;
  final String id;
  final String name;
  final String title;
  final String lore;
  final List<Role> roles;
  final String avatar;
  final List<Skin> skins;
  final Passive passive;
  final List<Spell> spells;

  const Champion({
    this.key,
    this.id,
    this.name,
    this.title,
    this.lore,
    this.roles,
    this.avatar,
    this.skins,
    this.passive,
    this.spells,
  });

  factory Champion.fromMap(Map<String, dynamic> map, String avatarUrl,
          String passiveUrl, String spellUrl) =>
      Champion(
        key: map['key'],
        id: map['id'],
        name: map['name'],
        title: map['title'],
        lore: map['lore'],
        roles: (map['tags'] as List)
            .map(
              (roleString) => Role.values.singleWhere(
                (role) =>
                    role.toString().toLowerCase() ==
                    'role.$roleString'.toLowerCase(),
              ),
            )
            .toList(),
        avatar:
            (avatarUrl == null) ? null : '$avatarUrl/${map['image']['full']}',
        skins: (map['skins'] == null)
            ? null
            : (map['skins'] as List)
                .map((skinMap) => Skin.fromMap(skinMap, map['id']))
                .toList(),
        passive: (map['passive'] == null)
            ? null
            : Passive.fromMap(map['passive'], passiveUrl),
        spells: (map['spells'] == null)
            ? null
            : (map['spells'] as List)
                .map((spellMap) => Spell.fromMap(spellMap, spellUrl))
                .toList(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Champion && identical(key, other.key);

  @override
  int get hashCode => key.hashCode;
}
