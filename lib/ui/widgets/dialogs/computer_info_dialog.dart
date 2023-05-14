import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:unica_cybercoffee/domain/models/computerUI.dart';
import 'package:unica_cybercoffee/domain/models/computer_states.dart';

class ComputerInfoDialog extends StatefulWidget {
  const ComputerInfoDialog({
    super.key, required this.computerUI,
  });
  final ComputerUI computerUI;


  @override
  State<ComputerInfoDialog> createState() => _ComputerInfoDialogState();
}

class _ComputerInfoDialogState extends State<ComputerInfoDialog> {
  int controllerState = 0;
  int controllerUserAction = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Datos de la Computadora'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                Navigator.of(context).pop({'state': 0, 'userAction': controllerUserAction});
              },
              hoverColor: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: const Text(
                    'Disponible',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Estado',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          MyDropdownMenu(
            computerUI: widget.computerUI,
            onChanged: (int index) {
              setState(() {
                controllerState = index;
              });
            },
            items: [
              ComputerStates.getStateLable(ComputerStates.disponible),
              ComputerStates.getStateLable(ComputerStates.mantenimiento),
              ComputerStates.getStateLable(ComputerStates.reparacion),
              ComputerStates.getStateLable(ComputerStates.proyecto),
            ],
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Usuario',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {
              Navigator.of(context).pop();
            },
            hoverColor: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Text(
                  'Historial',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {
              Navigator.of(context).pop();
            },
            hoverColor: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Text(
                  'Sancionar',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            Navigator.of(context).pop(
                {'state': controllerState, 'userAction': controllerUserAction});
          },
          hoverColor: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: const Text(
                'Guardar',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyDropdownMenu extends StatefulWidget {
  MyDropdownMenu({super.key, required this.items, required this.onChanged, required this.computerUI});
  final List<String> items;
  final ComputerUI computerUI;
  final void Function(int value) onChanged;

  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  String _selectedItem = '';

  @override
  void initState() {
    _selectedItem = widget.computerUI.state;
    // TODO: implement initState
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
          widget.onChanged(
              widget.items.indexOf(newValue ?? widget.computerUI.state));
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
