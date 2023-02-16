class Pokemon {
  final String name;
  final String type;
  final String sprite;
  final int id;

  const Pokemon({
    required this.name,
    required this.type,
    required this.sprite,
    required this.id,
  });
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      sprite: json['sprites']['front_default'],
      type: getType(json['types']),
      id: json['id'],
    );
  }

  static String getType(List types) {
    late String type = types.first['type']['name'] + " - " + types.last['type']['name'];

    return type;
  }
}

