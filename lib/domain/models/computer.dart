class Computer {
  Computer({required this.name, required this.imageUrl, required this.state});

  String name;
  String state;
  String imageUrl;

  static Computer fromMap(Map<dynamic, dynamic> data) {
    return Computer(
        name: data['name'], imageUrl: data['imageUrl'], state: data['state']);
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'state': state,
    };
  }
}
