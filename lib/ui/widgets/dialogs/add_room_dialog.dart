import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/domain/models/room.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';
import 'package:unica_cybercoffee/services/API/room.dart' as room;
import 'package:unica_cybercoffee/services/API/api_connection.dart';

class AddRoomDialog extends StatefulWidget {
  const AddRoomDialog({super.key});

  @override
  State<AddRoomDialog> createState() => _AddRoomDialogState();
}

class _AddRoomDialogState extends State<AddRoomDialog> {
  final FocusNode focusNode = FocusNode();
  TextEditingController nameRoomController = TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 2);

  @override
  void initState() {
    maskController.addListener(() {
      setState(() {});
    });
    setState(() {
      maskController.updateMask(0);
      focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {}
      },
      child: AlertDialog(
        title: const Text('Datos de la Aula'),
        content: CustomTextFileds(
          focusNode: focusNode,
          indexTextField: 0,
          textEditingController: nameRoomController,
          maskController: maskController,
          lable: 'Nombre del Aula',
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(10.0),
            hoverColor: Theme.of(context).colorScheme.secondary,
            onTap: onAddRoom,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Añadir Aula',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  onAddRoom() async {
    Room newRoom = Room(
        idComputerLab: dataStatic.idComputerLab, name: nameRoomController.text);
    await api.rooms.createRoom(newRoom);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
