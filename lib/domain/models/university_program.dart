class UniversityProgram {
  late int id;
  String name;

  UniversityProgram({
    this.id = 0,
    required this.name,
  });

  static UniversityProgram fromJson(Map<dynamic, dynamic> data) {
    return UniversityProgram(
      id: data['ID'],
      name: data['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
    };
  }

  @override
  String toString() => 'UniversityProgram {name: $name, id: $id}';
}
