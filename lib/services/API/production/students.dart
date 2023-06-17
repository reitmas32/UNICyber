import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/student.dart';
import 'package:unica_cybercoffee/services/API/api_interface.dart';
import 'package:unica_cybercoffee/services/API/production/base.dart' as BASE;

class ProductionStudentAPI implements StudentAPI {
  @override
  Future<Student> getStudent(String accountNumber) async {
    var url = Uri.parse('${BASE.URL_API}/api/v1/students/$accountNumber');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      if (success) {
        var newStudent = Student.fromJson(responseData['Data']);

        return Future(() => newStudent);
      }

      return Future(() => Student.empty());
    }

    return Future(() => Student.empty());
  }

  @override
  Future<Student> createStudent(Student student) async {
    var url = Uri.parse(
      '${BASE.HOST}::${BASE.PORT}/api/${BASE.apiVersion}/student',
    );

    if (student.email == '') {
      student.email = 'unica.student@gmail.com';
    }
    var body = jsonEncode(student.toJson());
    var response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);

      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(responseBody);

      // Acceder a los datos específicos dentro del objeto responseData
      var success = responseData['Success'];

      if (success) {
        var newStudent = Student.fromJson(responseData['Data']);

        return Future(() => newStudent);
      }
      return Future(() => Student.empty());
    }

    return Future(() => Student.empty());
  }
}
