import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/domain/models/state.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/services/API/api_connection.dart';

class ComputerInfoDialog extends StatefulWidget {
  const ComputerInfoDialog({
    super.key,
    required this.computer,
  });
  final Computer computer;

  @override
  State<ComputerInfoDialog> createState() => _ComputerInfoDialogState();
}

class _ComputerInfoDialogState extends State<ComputerInfoDialog> {
  int controllerState = -1;
  int controllerUserAction = 0;

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          Navigator.pop(context);
        }
        if (event.logicalKey == LogicalKeyboardKey.space) {
          onChangeStateAvailable();
          widget.computer.idState = dataStatic.states[0].id;
          Navigator.of(context).pop(widget.computer);
        }
      },
      child: AlertDialog(
        title: const Text('Datos de la Computadora'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () async {
                  await onChangeStateAvailable();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop(widget.computer);
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
              computer: widget.computer,
              onChanged: (int index) {
                setState(() {
                  controllerState = index;
                });
              },
              items: dataStatic.states
                  .map((stateComputer) => stateComputer.name)
                  .toList(),
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
                Navigator.of(context).pop(widget.computer);
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
                Navigator.of(context).pop(widget.computer);
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
            onTap: () async {
              await onChangeState();

              // ignore: use_build_context_synchronously
              Navigator.of(context).pop(widget.computer);
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
      ),
    );
  }

  onChangeStateAvailable() async {
    await api.states.setStateOfComputer(widget.computer.id, 1);
    setState(() {
      widget.computer.idState = dataStatic.states[0].id;
    });
  }

  onChangeState() async {
    if (controllerState >= 1) {
      await api.states.setStateOfComputer(
          widget.computer.id, dataStatic.states[controllerState].id);
      setState(() {
        widget.computer.idState = dataStatic.states[controllerState].id;
      });
    }
  }
}

class MyDropdownMenu extends StatefulWidget {
  const MyDropdownMenu(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.computer});
  final List<String> items;
  final Computer computer;
  final void Function(int value) onChanged;

  @override
  MyDropdownMenuState createState() => MyDropdownMenuState();
}

class MyDropdownMenuState extends State<MyDropdownMenu> {
  String _selectedItem = '';

  @override
  void initState() {
    _selectedItem = dataStatic.states
        .firstWhere(
          (state) => state.id == widget.computer.idState,
          orElse: () => StateComputer(
            name: '',
            img: '',
          ),
        )
        .name;
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
              widget.items.indexOf(newValue ?? widget.computer.state));
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
