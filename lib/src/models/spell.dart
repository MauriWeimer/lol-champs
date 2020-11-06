class Spell {
  final String id;
  final String name;
  final String description;
  final String image;

  const Spell({this.id, this.name, this.description, this.image});

  factory Spell.fromMap(Map<String, dynamic> map, String spellUrl) => Spell(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        image: '$spellUrl/${map['image']['full']}',
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Spell && identical(id, other.id);

  @override
  int get hashCode => id.hashCode;
}
