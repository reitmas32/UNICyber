import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:unica_cybercoffee/domain/models/computerUI.dart';
import 'package:unica_cybercoffee/domain/models/computer_room.dart';
import 'package:unica_cybercoffee/domain/models/computer_states.dart';
import 'package:unica_cybercoffee/services/DB/database_static.dart';
import 'package:unica_cybercoffee/services/DB/idatabase_UI.dart';
import 'package:unica_cybercoffee/tools/randomID.dart';

class DataBaseStaticUI extends IDataBaseUI {
  List<ComputerUI> computers = [];
  List<ComputerRoomUI> computerRooms = [];

  Future<bool> loadData() async {
    final directory = await getApplicationSupportDirectory();

    final collectionComputerRoomsFile =
        File('${directory.path}/collection_computer_rooms.json');
    if (!await collectionComputerRoomsFile.exists()) {
      await collectionComputerRoomsFile.create();
    } else {
      final collectionComputerRoomsJson =
          collectionComputerRoomsFile.readAsStringSync();
      if (collectionComputerRoomsJson.isNotEmpty) {
        final List<dynamic> collectionComputerRoomsList =
            jsonDecode(collectionComputerRoomsJson);
        computerRooms = collectionComputerRoomsList
            .map((json) => ComputerRoomUI.fromMap(json))
            .toList();
      }
    }

    final collectionComputersFile =
        File('${directory.path}/collection_computers.json');
    if (!await collectionComputersFile.exists()) {
      await collectionComputersFile.create();
    } else {
      final collectionComputersJson =
          collectionComputersFile.readAsStringSync();
      if (!collectionComputersJson.isEmpty) {
        final List<dynamic> collectionComputersList =
            jsonDecode(collectionComputersJson);
        computers = collectionComputersList
            .map((json) => ComputerUI.fromMap(json))
            .toList();
      }
    }

    return Future(() => true);
  }

  Future<bool> saveData() async {
    final directory = await getApplicationSupportDirectory();
    final collectionComputers =
        File('${directory.path}/collection_computers.json');
    final sinkCollectionComputers = collectionComputers.openWrite();

    final collectionComputerRooms =
        File('${directory.path}/collection_computer_rooms.json');
    final sinkCollectionComputerRooms = collectionComputerRooms.openWrite();

    sinkCollectionComputers.write(
        jsonEncode(computers.map((computer) => computer.toJson()).toList()));
    sinkCollectionComputerRooms.write(jsonEncode(
        computerRooms.map((computer) => computer.toJson()).toList()));

    await sinkCollectionComputers.flush();
    await sinkCollectionComputers.close();

    await sinkCollectionComputerRooms.flush();
    await sinkCollectionComputerRooms.close();
    return Future(() => true);
  }

  @override
  Future<ComputerUI> createComputer(
      String nameRoom, String nameComputer) async {
    final randomID = randomString();
    var computerRoom = await findComputerRooms(nameRoom);
    var computer = ComputerUI(
      name: nameComputer,
      imageUrl:
          'https://em-content.zobj.net/source/microsoft-teams/337/desktop-computer_1f5a5-fe0f.png',
      state: ComputerStates.disponible,
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

  Future<bool> setStateComputer(String id, String state) {
    String imageUrlDisponible =
        'https://em-content.zobj.net/source/microsoft-teams/337/desktop-computer_1f5a5-fe0f.png';
    String imageUrlReparacion =
        'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/reparacion.png';
    String imageUrlProyecto =
        'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/proyecto.png';
    String imageUrlMantenimiento =
        'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/mantenimiento.png';

    ComputerUI computer = computers.firstWhere(
      (element) => element.id == id,
    );
    computer.state = state;

    if (ComputerStates.disponible == computer.state) {
      computer.imageUrl = imageUrlDisponible;
    }
    if (ComputerStates.mantenimiento == computer.state) {
      computer.imageUrl = imageUrlMantenimiento;
    }
    if (ComputerStates.reparacion == computer.state) {
      computer.imageUrl = imageUrlReparacion;
    }
    if (ComputerStates.proyecto == computer.state) {
      computer.imageUrl = imageUrlProyecto;
    }

    return Future(() => true);
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
      ComputerRoomUI(
          id: randomID,
          name: nameRoom,
          idUserAdmin: databaseStatic.activeUserAdmin.id),
    );

    return Future(() => randomID);
  }

  @override
  Future<ComputerRoomUI> findComputerRooms(String nameRoom) async {
    ComputerRoomUI result = computerRooms.firstWhere(
        (computerRoom) => computerRoom.name == nameRoom,
        orElse: () => ComputerRoomUI(name: 'None', idUserAdmin: 'None'));

    return result;
  }

  @override
  Future<List<ComputerRoomUI>> getComputerRooms() async {
    var idUser = databaseStatic.activeUserAdmin.id;
    var computersRoomOfUser = computerRooms
        .where((computerRoom) => computerRoom.idUserAdmin == idUser)
        .toList();
    if (computersRoomOfUser.isEmpty) {
      await createComputerRooms('Aula 1');
      await createComputerRooms('Nueva Aula');
    }

    var computersRoomOfUser2 = computerRooms
        .where((computerRoom) => computerRoom.idUserAdmin == idUser)
        .toList();
    return Future(() => computerRooms
        .where((computerRoom) => computerRoom.idUserAdmin == idUser)
        .toList());
  }

  @override
  Future<bool> deleteComputerRooms(String nameRoom) async {
    computerRooms.removeLast();
    return Future(() => true);
  }
}

DataBaseStaticUI databaseUI_Static = DataBaseStaticUI();
