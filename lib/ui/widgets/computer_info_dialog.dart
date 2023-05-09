import 'package:flutter/material.dart';

class ComputerInfoDialog extends StatelessWidget {
  const ComputerInfoDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Datos de la Computadora'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Disponible'),
          Text('Estado'),
          Text('Usuario'),
          Text('Informacion'),
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
              child: const Text('Guardar'),
            ),
          ),
        ),
      ],
    );
  }
}
