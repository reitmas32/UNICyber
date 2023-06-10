import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/user.dart';
import 'package:unica_cybercoffee/services/API/api_interface.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';

class ProductionAccountAPI implements AccountAPI {
  @override
  Future<bool> signUp(User user) async {
    var url = Uri.parse('http://localhost:3000/api/v1/signup');
    var body = jsonEncode(user.toJson());
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      print(responseData);

      return Future(() => success);
    }
    return Future(() => false);
  }

  @override
  Future<bool> signIn(User user) async {
    var url = Uri.parse('http://localhost:3000/api/v1/signin');
    var body = jsonEncode(user.toJson());
    var response = await http.put(url, body: body);
    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      if (success) {
        dataStatic.jwt = responseData['Data']['token_jwt'];
        dataStatic.userName = user.userName;
      }

      return Future(() => success);
    }
    return Future(() => false);
  }
}
