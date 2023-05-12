
class ComputerRoomUI{
  late String id;
  String idUserAdmin;
  String name;

  ComputerRoomUI({this.id = 'dash6854hyabdys', required this.name, required this.idUserAdmin});

  static ComputerRoomUI fromMap(Map<dynamic, dynamic> data){
    return ComputerRoomUI(id: data['id'], name: data['name'], idUserAdmin: data['idUserAdmin']);
  }

  Map<dynamic, dynamic> toMap(){

    return {'id': id, 'name': name, 'idUserAdmin': idUserAdmin};
  }

    Map<String, dynamic> toJson(){

    return {'id': id, 'name': name, 'idUserAdmin': idUserAdmin};
  }
}