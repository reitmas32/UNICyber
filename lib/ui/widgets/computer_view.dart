import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';

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
    final editableProvider = Provider.of<EditableUIProvider>(context);

    return Container(
      decoration: BoxDecoration(
        border: editableProvider.editable
            ? Border.all(
                color: Colors.blue,
                width: 2.0,
              )
            : null,
      ),
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
