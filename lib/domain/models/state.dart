class StateComputer {
  late int id;
  String name;
  String img;

  StateComputer({
    this.id = 0,
    required this.name,
    required this.img,
  });

  static StateComputer fromJson(Map<dynamic, dynamic> data) {
    return StateComputer(
      id: data['ID'],
      name: data['Name'],
      img: data['Image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Image': img,
    };
  }

  @override
  String toString() => 'StateComputer{name: $name, id: $id, img: $img}';
}
