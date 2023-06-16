import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/services/API/api_connection.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';

class LoanComputerDialog extends StatefulWidget {
  const LoanComputerDialog({
    super.key,
    required this.computer,
  });
  final Computer computer;

  @override
  State<LoanComputerDialog> createState() => _LoanComputerDialogState();
}

class _LoanComputerDialogState extends State<LoanComputerDialog> {
  TextEditingController accountNumberController =
      TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 1);

  @override
  void initState() {
    maskController.addListener(() {
      setState(() {});
    });
    setState(() {
      maskController.updateMask(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
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
              autofocus: true,
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
            onTap: () async {
              var result = await api.loanService.createLoanOfComputer(
                widget.computer.id,
                accountNumberController.text,
              );
              if (result) {
                setState(() {
                  widget.computer.idState = dataStatic.states[5].id;
                });
              }
              Navigator.of(context).pop(widget.computer);
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
