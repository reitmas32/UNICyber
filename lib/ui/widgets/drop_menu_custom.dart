import 'package:flutter/material.dart';

class DropdownMenuCustom extends StatefulWidget {
  const DropdownMenuCustom({
    super.key,
    required this.items,
    required this.onChanged,
    required this.controller,
  });
  final List<String> items;
  final void Function(int value) onChanged;
  final DropMenuController controller;

  @override
  DropdownMenuCustomState createState() => DropdownMenuCustomState();
}

class DropdownMenuCustomState extends State<DropdownMenuCustom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Material(
        elevation: 20,
        shadowColor: Colors.blueAccent,
        child: DropdownButton(
          borderRadius: BorderRadius.circular(5.0),
          elevation: 5,
          hint: const Text('Selecciona una opción'),
          value: widget.items[widget.controller.currentSelected],
          onChanged: (newValue) {
            setState(() {
              widget.controller
                  .updateMask(widget.items.indexOf(newValue ?? ''));
            });
          },
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DropMenuController extends ChangeNotifier {
  late int currentSelected;
  DropMenuController() {
    currentSelected = 0;
  }

  updateMask(int index) {
    if (index >= 0) {
      currentSelected = index;
      notifyListeners();
    }
  }
}
