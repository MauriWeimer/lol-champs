class Passive {
  final String id;
  final String name;
  final String description;
  final String image;

  const Passive({this.id, this.name, this.description, this.image});

  factory Passive.fromMap(Map<String, dynamic> map, String passiveUrl) =>
      Passive(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        image: '$passiveUrl/${map['image']['full']}',
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Passive && identical(id, other.id);

  @override
  int get hashCode => id.hashCode;
}
