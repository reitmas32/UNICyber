import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddComputerDialog extends StatefulWidget {
  const AddComputerDialog(
      {super.key, required this.onTap, required this.nameNewComputer});

  final void Function() onTap;
  final TextEditingController nameNewComputer;

  @override
  State<AddComputerDialog> createState() => _AddComputerDialogState();
}

class _AddComputerDialogState extends State<AddComputerDialog> {
  final FocusNode nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    nameFocusNode.requestFocus();
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: const Text('Datos de la Compitadora'),
        content: TextField(
          controller: widget.nameNewComputer,
          focusNode: nameFocusNode,
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: widget.onTap,
            hoverColor: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Text('Añadir Computadora'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
