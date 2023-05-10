import 'package:flutter/material.dart';

class LoanComputerDialog extends StatelessWidget {
  LoanComputerDialog({
    super.key,
  });

  final FocusNode nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    nameFocusNode.requestFocus();
    return AlertDialog(
      title: const Text('Numero de cuenta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            focusNode: nameFocusNode,
          ),
        ],
      ),
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            Navigator.of(context).pop();
          },
          hoverColor: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: const Text('Confirmar'),
            ),
          ),
        ),
      ],
    );
  }
}
