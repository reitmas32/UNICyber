import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/room.dart';
import 'package:unica_cybercoffee/services/API/api_interface.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';

class ProductionRoomAPI implements RoomAPI {
  @override
  Future<bool> createRoom(Room computerLab) async {
    var url = Uri.parse('http://localhost:3000/api/v1/room');
    var body = jsonEncode(computerLab.toJson());
    var response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      return Future(() => success);
    }

    return Future(() => false);
  }

  @override
  Future<bool> getRoomsOfComputerLab(int idComputerLab) async {
    var url = Uri.parse(
        'http://localhost:3000/api/v1/rooms/${dataStatic.idComputerLab}');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      if (success) {
        dataStatic.roomsOfComputerLab.clear();
        for (var computerLab in responseData['Data']) {
          dataStatic.roomsOfComputerLab.add(Room.fromJson(computerLab));
        }
      }

      return Future(() => success);
    }

    return Future(() => false);
  }
}
