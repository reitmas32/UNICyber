import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';
import 'package:unica_cybercoffee/services/API/api_connection.dart';

class AddComputerDialog extends StatefulWidget {
  const AddComputerDialog({super.key});

  @override
  State<AddComputerDialog> createState() => _AddComputerDialogState();
}

class _AddComputerDialogState extends State<AddComputerDialog> {
  final FocusNode focusNode = FocusNode();
  TextEditingController nameComputerController =
      TextEditingController(text: '');
  TextEditingController typeComputerController =
      TextEditingController(text: '');
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
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {}
      },
      child: AlertDialog(
        title: const Text('Datos de la Computadora'),
        content: IntrinsicHeight(
          child: Column(
            children: [
              CustomTextFileds(
                autofocus: true,
                indexTextField: 0,
                textEditingController: nameComputerController,
                maskController: maskController,
                lable: 'Nombre',
                padding: const EdgeInsets.all(8.0),
              ),
              CustomTextFileds(
                indexTextField: 1,
                textEditingController: typeComputerController,
                maskController: maskController,
                lable: 'Tipo',
                padding: const EdgeInsets.all(8.0),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: onAddComputer,
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

  onAddComputer() async {
    Computer newComputer = Computer(
      name: nameComputerController.text,
      type: typeComputerController.text,
      idRoom: dataStatic.idRoomCurrent,
      idState: dataStatic.states[0].id,
    );
    await api.computers.createComputer(newComputer);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
