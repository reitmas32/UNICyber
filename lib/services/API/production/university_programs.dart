import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/university_program.dart';
import 'package:unica_cybercoffee/services/API/api_interface.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';

class ProductionUniversityProgramAPI implements UniversityProgramAPI {
  @override
  Future<bool> getUniversityPrograms() async {
    var url = Uri.parse('http://localhost:3000/api/v1/university-programs');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(responseBody);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      if (success) {
        for (var universityProgram in responseData['Data']) {
          dataStatic.universityPrograms
              .add(UniversityProgram.fromJson(universityProgram));
        }
      }

      return Future(() => success);
    }

    return Future(() => false);
  }
}
