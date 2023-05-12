class UserAdmin {
  String userName;
  String password;
  String id;

  UserAdmin({
    required this.userName,
    required this.password,
    required this.id,
  });

  static UserAdmin fromJson(Map<dynamic, dynamic> data) {
    return UserAdmin(
      userName: data['userName'],
      password: data['password'],
      id: data['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "password": password,
      "id": id,
    };
  }

  @override
  String toString() {
    
    return "userName: $userName, password: $password";
  }
}
