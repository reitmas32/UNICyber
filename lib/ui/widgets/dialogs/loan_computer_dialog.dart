import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';

class LoanComputerDialog extends StatefulWidget {
  LoanComputerDialog({
    super.key,
  });

  @override
  State<LoanComputerDialog> createState() => _LoanComputerDialogState();
}

class _LoanComputerDialogState extends State<LoanComputerDialog> {
  TextEditingController accountNumberController =
      TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 1);

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          //widget.onTap();
        }
      },
      child: AlertDialog(
        title: const Text('Numero de cuenta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFileds(
              focusNode: focusNode,
              indexTextField: 0,
              textEditingController: accountNumberController,
              maskController: maskController,
              lable: 'AccountNumber',
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
      ),
    );
  }
}
