import 'package:unica_cybercoffee/domain/models/computer_room.dart';

class UnicaRoom{
  List<ComputerRoom> computerRooms = [];

  UnicaRoom({required this.computerRooms});

  static UnicaRoom fromMap(Map<dynamic, dynamic> data){
    List<ComputerRoom> computerRooms = [];
    for(var computerRoom in data['computerRooms']){
      computerRooms.add(ComputerRoom.fromMap(computerRoom));
    }
    return UnicaRoom(computerRooms: computerRooms);
  }

  Map<dynamic, dynamic> toMap(){
    List<Map<dynamic, dynamic>> computerRoomsMap = [];

    for(var computerRoom in computerRooms){
      computerRoomsMap.add(computerRoom.toMap());
    }

    return {'computerRooms': computerRoomsMap};
  }
}