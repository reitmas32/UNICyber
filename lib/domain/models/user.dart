class User {
  String name;
  String lastName;
  String email;
  String userName;
  String phoneNumber;
  String dateOfBirth;
  String password;
  String role;

  User({
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.userName = '',
    this.phoneNumber = '',
    this.dateOfBirth = '',
    this.password = '',
    this.role = '',
  });

  static User fromJson(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      lastName: data['last_name'],
      email: data['email'],
      userName: data['user_name'],
      phoneNumber: data['phone_number'],
      dateOfBirth: data['date_of_birth'],
      password: data['password'],
      role: data['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "last_name": lastName,
      "email": email,
      "user_name": userName,
      "phone_number": phoneNumber,
      "date_of_birth": dateOfBirth,
      "password": password,
      "role": role,
    };
  }
}
