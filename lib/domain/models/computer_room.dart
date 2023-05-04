
class ComputerRoomUI{
  late String id;
  String name;

  ComputerRoomUI({this.id = 'dash6854hyabdys', required this.name});

  static ComputerRoomUI fromMap(Map<dynamic, dynamic> data){
    return ComputerRoomUI(id: data['id'], name: data['name']);
  }

  Map<dynamic, dynamic> toMap(){

    return {'id': id, 'name': name};
  }
}