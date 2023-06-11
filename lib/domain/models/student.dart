class Student {
  int id;
  String name;
  String lastName;
  String email;
  String universityProgram;
  String accountNumber;
  int semester;

  Student({
    this.id = 0,
    required this.name,
    required this.accountNumber,
    required this.email,
    required this.lastName,
    required this.semester,
    required this.universityProgram,
  });

  Student.empty({
    this.id = 0,
    this.name = '',
    this.accountNumber = '',
    this.email = '',
    this.lastName = '',
    this.semester = 0,
    this.universityProgram = '',
  });

  static Student fromJson(Map<dynamic, dynamic> data) {
    return Student(
      id: data['ID'],
      name: data['Name'],
      accountNumber: data['AccountNumber'],
      email: data['Email'],
      lastName: data['LastName'],
      semester: data['Semester'],
      universityProgram: data['UniversityProgram'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'AccountNumber': accountNumber,
      'Email': email,
      'LastName': lastName,
      'Semester': semester,
      'UniversityProgram': universityProgram,
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
        universityProgram.isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }
}
