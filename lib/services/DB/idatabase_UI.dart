import 'package:unica_cybercoffee/domain/models/computerUI.dart';
import 'package:unica_cybercoffee/domain/models/computer_room.dart';

class IDataBaseUI {
  Future<ComputerUI> createComputer(
      String nameRoom, String nameComputer) async {
    return Future(() => ComputerUI.fromMap({}));
  }

  Future<bool> deleteComputer(String nameComputer) async {
    return Future(() => false);
  }

  Future<List<ComputerUI>> getComputers() async {
    return Future(() => []);
  }

  Future<String> createComputerRooms(String nameRoom) async {
    return Future(() => 'hbydsba845adyb');
  }

  Future<ComputerRoomUI> findComputerRooms(String nameRoom) async {
    return Future(() => ComputerRoomUI(name: 'None'));
  }

  Future<List<ComputerRoomUI>> getComputerRooms() async {
    return Future(() => []);
  }

  Future<bool> deleteComputerRooms(String nameRoom) async {
    return Future(() => false);
  }
}
