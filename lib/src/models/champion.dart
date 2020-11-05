import './skin.dart';

class Champion {
  final String key;
  final String id;
  final String name;
  final String title;
  final String lore;
  final String avatar;
  final List<Skin> skins;

  const Champion({
    this.key,
    this.id,
    this.name,
    this.title,
    this.lore,
    this.avatar,
    this.skins,
  });

  factory Champion.fromMap(Map<String, dynamic> map, String avatar) => Champion(
        key: map['key'],
        id: map['id'],
        name: map['name'],
        title: map['title'],
        lore: map['lore'],
        avatar: avatar,
        skins: (map['skins'] as List)
            ?.map((skinMap) => Skin.fromMap(skinMap, map['id']))
            ?.toList(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Champion && identical(key, other.key);

  @override
  int get hashCode => key.hashCode;
}
