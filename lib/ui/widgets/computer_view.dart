import 'package:flutter/material.dart';

class ComputerView extends StatelessWidget {
  const ComputerView({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          Text(name),
          Image.network(
            imageUrl,
          ),
        ],
      ),
    );
  }
}