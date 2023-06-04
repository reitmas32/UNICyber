import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';

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
