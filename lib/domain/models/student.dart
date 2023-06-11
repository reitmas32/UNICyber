class Student {
  int id;
  String name;
  String lastName;
  String email;
  int idUniversityProgram;
  String accountNumber;
  int semester;

  Student({
    this.id = 0,
    required this.name,
    required this.accountNumber,
    required this.email,
    required this.lastName,
    required this.semester,
    required this.idUniversityProgram,
  });

  Student.empty({
    this.id = 0,
    this.name = '',
    this.accountNumber = '',
    this.email = '',
    this.lastName = '',
    this.semester = 0,
    this.idUniversityProgram = 0,
  });

  static Student fromJson(Map<dynamic, dynamic> data) {
    return Student(
      id: data['ID'],
      name: data['Name'],
      accountNumber: data['AccountNumber'],
      email: data['Email'],
      lastName: data['LastName'],
      semester: data['Semester'],
      idUniversityProgram: data['IdUniversityProgram'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'account_number': accountNumber,
      'email': email,
      'last_name': lastName,
      'semester': semester,
      'id_university_program': idUniversityProgram,
    };
  }

  @override
  String toString() => 'Student{name: $name, id: $id}';

  bool isEmpty() {
    return name.isEmpty ||
        accountNumber.isEmpty ||
        email.isEmpty ||
        lastName.isEmpty ||
        semester == 0 ||
        idUniversityProgram == 0;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }
}
