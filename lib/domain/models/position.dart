class Position {
  Position({required this.x, required this.y});
  double x;
  double y;

  static fromJSON(Map<String, dynamic> json) {
    return Position(
      x: json['x'].toDouble(),
      y: json['y'].toDouble(),
    );
  }

  @override
  String toString() => 'Position(x: $x, y: $y)';
}
