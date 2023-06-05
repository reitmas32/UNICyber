import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';

Future<bool> createComputerLab(ComputerLab computerLab) async {
  var url = Uri.parse('http://localhost:3000/api/v1/computer-lab');
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

Future<bool> getComputerLabs() async {
  var url = Uri.parse('http://localhost:3000/api/v1/computer-labs-limit/4');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
    var responseData = jsonDecode(response.body);

    // Acceder a los datos específicos dentro del objeto responseData
    var success = responseData['Success'];

    if (success) {
      dataStatic.allComputerLabs.clear();
      for (var computerLab in responseData['Data']) {
        dataStatic.allComputerLabs.add(ComputerLab.fromJson(computerLab));
      }
    }

    return Future(() => success);
  }
  return Future(() => false);
}

Future<bool> linkComputerLab(ComputerLab computerLab, String userName) async {
  var url = Uri.parse('http://localhost:3000/api/v1/link-account');
  var body = jsonEncode({
    'idComputerLab': computerLab.idComputerLab,
    'username': userName,
  });
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
