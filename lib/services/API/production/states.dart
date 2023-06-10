import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/state.dart';
import 'package:unica_cybercoffee/services/API/api_interface.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';

class ProductionStateAPI implements StateAPI {
  @override
  Future<bool> getStates() async {
    var url = Uri.parse('http://localhost:3000/api/v1/states');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      if (success) {
        for (var state in responseData['Data']) {
          dataStatic.states.add(StateComputer.fromJson(state));
        }
      }

      return Future(() => success);
    }

    return Future(() => false);
  }

  @override
  Future<bool> setStateOfComputer(int idComputer, int idState) async {
    var url = Uri.parse(
        'http://localhost:3000/api/v1/computer-set-state/$idComputer');
    var body = jsonEncode({'id_state': idState});
    var response = await http.put(url, body: body);

    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      return Future(() => success);
    }

    return Future(() => false);
  }
}
