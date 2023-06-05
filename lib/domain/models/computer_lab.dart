class ComputerLab {
  String name;
  String description;
  String idComputerLab;

  ComputerLab({
    this.name = '',
    this.description = '',
    this.idComputerLab = '',
  });

  static ComputerLab fromJson(Map<String, dynamic> data) {
    return ComputerLab(
      name: data['Name'],
      description: data['Description'],
      idComputerLab: data['IdComputerLab'],
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
    return 'Name: $name, Description $description, ID: $idComputerLab';
  }
}
