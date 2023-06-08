class ComputerLab {
  String name;
  String description;
  int id;

  ComputerLab({
    this.name = '',
    this.description = '',
    this.id = 0,
  });

  static ComputerLab fromJson(Map<String, dynamic> data) {
    return ComputerLab(
      name: data['Name'],
      description: data['Description'],
      id: data['ID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
    };
  }

  @override
  String toString() {
    return 'Name: $name, Description $description, ID: $id';
  }
}
