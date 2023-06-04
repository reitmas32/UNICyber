class ComputerLab {
  String name;
  String description;

  ComputerLab({
    this.name = '',
    this.description = '',
  });

  static ComputerLab fromJson(Map<String, dynamic> data) {
    return ComputerLab(
      name: data['name'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
    };
  }
}
