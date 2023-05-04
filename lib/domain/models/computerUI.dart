import 'package:unica_cybercoffee/domain/models/position.dart';

class ComputerUI extends Position {
  ComputerUI({
    required this.name,
    required this.imageUrl,
    required this.state,
    required this.idComputerRoom,
    required this.id,
    required super.x,
    required super.y,
  });

  String name;
  String state;
  String imageUrl;
  String idComputerRoom;
  String id;

  static ComputerUI fromMap(Map<dynamic, dynamic> data) {
    return ComputerUI(
      name: data['name'],
      imageUrl: data['imageUrl'],
      state: data['state'],
      idComputerRoom: data['idComputerRoom'],
      x: data['x'],
      y: data['y'],
      id: data['id'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'state': state,
      'idComputerRoom': idComputerRoom,
      'x': x,
      'y': y,
      'id': id
    };
  }

  @override
  String toString() => 'ComputerUI{name: $name, imageUrl: $imageUrl, state: $state, idComputerRoom: $idComputerRoom, id: $id}';
}
