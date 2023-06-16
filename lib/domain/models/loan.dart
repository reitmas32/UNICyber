class Loan {
  Loan({
    this.id = -1,
    required this.idComputer,
    required this.idStudent,
    required this.sesionStart,
    required this.sesionEnd,
  });

  int id;
  int idComputer;
  int idStudent;
  String sesionStart;
  String sesionEnd;

  Loan.empty({
    this.id = 0,
    this.idComputer = 0,
    this.idStudent = 0,
    this.sesionStart = '',
    this.sesionEnd = '',
  });

  static Loan fromJson(Map<dynamic, dynamic> data) {
    return Loan(
      id: data['ID'],
      idComputer: data['IdComputer'],
      idStudent: data['IdStudent'],
      sesionStart: data['SesionStart'],
      sesionEnd: data['SesionEnd'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }

  bool isEmpty() {
    return sesionStart.isEmpty ||
        sesionEnd.isEmpty ||
        idComputer == 0 ||
        idStudent == 0;
  }

  bool isNotEmpty() => !isEmpty();
}
