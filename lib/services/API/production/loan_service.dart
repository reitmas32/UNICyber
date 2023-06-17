import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unica_cybercoffee/domain/models/loan.dart';
import 'package:unica_cybercoffee/domain/models/student.dart';
import 'package:unica_cybercoffee/services/API/api_interface.dart';
import 'package:unica_cybercoffee/services/API/production/base.dart' as BASE;

class ProductionLoanServiceAPI implements LoanServiceAPI {
  @override
  Future<bool> createLoanOfComputer(
      int idComputer, String accountNumber) async {
    var url =
        Uri.parse('${BASE.URL_API}/api/v1/loan-computer-by-account-number');
    var body = jsonEncode(
      {
        'account_number': accountNumber,
        'id_computer': idComputer,
      },
    );
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
  Future<bool> leaveLoanOfComputer(int idComputer) async {
    var url = Uri.parse('${BASE.URL_API}/api/v1/loan-leave-computer');
    var body = jsonEncode(
      {
        'id_computer': idComputer,
      },
    );
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

  @override
  Future<Loan> getLoanByIdComputer(int idComputer) async {
    var url = Uri.parse('${BASE.URL_API}/api/v1/loan-computer/$idComputer');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // La petición fue exitosa, extraer los datos del cuerpo de la respuesta
      var responseData = jsonDecode(response.body);
      if (responseData['Success']) {
        final loan = Loan.fromJson(responseData['Data']);
        return Future(() => loan);
      }
      // Acceder a los datos específicos dentro del objeto responseData
    }

    return Future(() => Loan.empty());
  }
}
