import 'package:unica_cybercoffee/services/API/api_interface.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/services/API/production/base.dart' as BASE;

class ProductionComputerAPI implements ComputerAPI {
  @override
  Future<bool> createComputer(Computer computer) async {
    var url = Uri.parse('${BASE.URL_API}/api/v1/computer');
    var body = jsonEncode(computer.toJson());
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
  Future<bool> getComputersOfRoom(int idRoom) async {
    var url = Uri.parse('${BASE.URL_API}/api/v1/computers/$idRoom');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      if (success) {
        dataStatic.computerOfRoom.clear();
        for (var computerLab in responseData['Data']) {
          dataStatic.computerOfRoom.add(Computer.fromJson(computerLab));
        }
      }

      return Future(() => success);
    }

    return Future(() => false);
  }

  @override
  Future<bool> updateComputer(Computer computer) async {
    var url = Uri.parse('${BASE.URL_API}/api/v1/computer/${computer.id}');
    var body = jsonEncode(computer.toJson());
    await http.put(url, body: body);
    return Future(() => true);
  }
}
