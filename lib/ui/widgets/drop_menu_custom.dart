import 'package:flutter/material.dart';

class DropdownMenuCustom extends StatefulWidget {
  const DropdownMenuCustom({
    super.key,
    required this.items,
    required this.onChanged,
  });
  final List<String> items;
  final void Function(int value) onChanged;

  @override
  DropdownMenuCustomState createState() => DropdownMenuCustomState();
}

class DropdownMenuCustomState extends State<DropdownMenuCustom> {
  String _selectedItem = '';

  @override
  void initState() {
    _selectedItem = widget.items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(5.0),
      elevation: 5,
      hint: const Text('Selecciona una opción'),
      value: _selectedItem,
      onChanged: (newValue) {
        setState(() {
          _selectedItem = newValue ?? widget.items.first;
        });
      },
      items: widget.items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
