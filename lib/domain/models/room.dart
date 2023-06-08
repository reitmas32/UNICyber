class Room {
  late int id;
  int idComputerLab;
  String name;
  int index;

  Room({
    this.id = 0,
    this.index = 0,
    required this.name,
    required this.idComputerLab,
  });

  static Room fromJson(Map<dynamic, dynamic> data) {
    return Room(
      id: data['ID'],
      name: data['Name'],
      idComputerLab: data['IdComputerLab'],
      index: data['Index'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {'id': id, 'name': name, 'id_computer_lab': idComputerLab};
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'id_computer_lab': idComputerLab};
  }
}
