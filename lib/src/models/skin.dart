class Skin {
  final String id;
  final int position;
  final String name;
  final String url;

  const Skin({this.id, this.position, this.name, this.url});

  factory Skin.fromMap(Map<String, dynamic> map, String championId) => Skin(
        id: map['id'],
        position: map['num'],
        name: map['name'],
        url:
            'http://ddragon.leagueoflegends.com/cdn/img/champion/loading/${championId}_${map['num']}.jpg',
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Skin && identical(id, other.id);

  @override
  int get hashCode => id.hashCode;
}
