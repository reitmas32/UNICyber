import 'package:unica_cybercoffee/domain/models/computerUI.dart';
import 'package:unica_cybercoffee/domain/models/computer_room.dart';
import 'package:unica_cybercoffee/services/DB/idatabase_UI.dart';
import 'package:unica_cybercoffee/tools/randomID.dart';

class DataBaseStaticUI extends IDataBaseUI {
  List<ComputerUI> computers = [];
  List<ComputerRoomUI> computerRooms = [];

  @override
  Future<ComputerUI> createComputer(
      String nameRoom, String nameComputer) async {
    final randomID = randomString();
    var computerRoom = await findComputerRooms(nameRoom);
    var computer = ComputerUI(
      name: nameComputer,
      imageUrl: 'imageUrl',
      state: 'state',
      id: randomID,
      x: 0,
      y: 0,
      idComputerRoom: computerRoom.id,
    );
    computers.add(
      computer,
    );

    return Future(() => computer);
  }

  @override
  Future<bool> deleteComputer(String nameComputer) async {
    return Future(() => false);
  }

  @override
  Future<List<ComputerUI>> getComputers() async {
    // TODO: implement getComputers
    return computers;
  }

  @override
  Future<String> createComputerRooms(String nameRoom) async {
    final randomID = randomString();
    computerRooms.add(
      ComputerRoomUI(id: randomID, name: nameRoom),
    );
    return Future(() => randomID);
  }

  @override
  Future<ComputerRoomUI> findComputerRooms(String nameRoom) async {
    ComputerRoomUI result = computerRooms.firstWhere(
        (computerRoom) => computerRoom.name == nameRoom,
        orElse: () => ComputerRoomUI(name: 'None'));

    return result;
  }

  @override
  Future<List<ComputerRoomUI>> getComputerRooms() async {
    return Future(() => computerRooms);
  }

  @override
  Future<bool> deleteComputerRooms(String nameRoom) async {
    computerRooms.removeLast();
    return Future(() => true);
  }
}
