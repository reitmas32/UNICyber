import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';

class AddComputerDialog extends StatefulWidget {
  const AddComputerDialog(
      {super.key, required this.onTap, required this.nameNewComputer});

  final void Function() onTap;
  final TextEditingController nameNewComputer;

  @override
  State<AddComputerDialog> createState() => _AddComputerDialogState();
}

class _AddComputerDialogState extends State<AddComputerDialog> {
  final FocusNode focusNode = FocusNode();
  TextEditingController nameComputerController =
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
    Size size = MediaQuery.of(context).size;
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          widget.onTap();
        }
      },
      child: AlertDialog(
        title: const Text('Datos de la Compitadora'),
        content: CustomTextFileds(
          focusNode: focusNode,
          indexTextField: 0,
          textEditingController: nameComputerController,
          maskController: maskController,
          lable: 'Password',
          padding:
              const EdgeInsets.symmetric(vertical: 16.0),
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
