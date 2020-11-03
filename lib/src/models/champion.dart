class Champion {
  final String key;
  final String name;
  final String title;
  final String lore;
  final String avatar;
  //final ....

  const Champion({this.key, this.name, this.title, this.lore, this.avatar});

  factory Champion.fromMap(Map<String, dynamic> map, String avatar) => Champion(
        key: map['key'],
        name: map['name'],
        title: map['title'],
        lore: map['lore'],
        avatar: avatar,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Champion && identical(key, other.key);

  @override
  int get hashCode => key.hashCode;
}
