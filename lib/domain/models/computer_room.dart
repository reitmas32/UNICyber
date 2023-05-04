import 'package:unica_cybercoffee/domain/models/computer.dart';

class ComputerRoom{
  List<Computer> computers = [];

  ComputerRoom({required this.computers});

  static ComputerRoom fromMap(Map<dynamic, dynamic> data){
    List<Computer> computers = [];
    for(var computer in data['computers']){
      computers.add(Computer.fromMap(computer));
    }
    return ComputerRoom(computers: computers);
  }

  Map<dynamic, dynamic> toMap(){
    List<Map<dynamic, dynamic>> computersMap = [];

    for(var computer in computers){
      computersMap.add(computer.toMap());
    }

    return {'computers': computersMap};
  }
}