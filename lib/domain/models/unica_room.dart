import 'package:unica_cybercoffee/domain/models/computer_room.dart';

class UnicaRoom{
  List<ComputerRoomUI> computerRooms = [];

  UnicaRoom({required this.computerRooms});

  static UnicaRoom fromMap(Map<dynamic, dynamic> data){
    List<ComputerRoomUI> computerRooms = [];
    for(var computerRoom in data['computerRooms']){
      computerRooms.add(ComputerRoomUI.fromMap(computerRoom));
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