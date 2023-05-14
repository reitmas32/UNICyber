import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/ui/widgets/action_button.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/info_user_dialog.dart';

class SearchUserDialog extends StatefulWidget {
  SearchUserDialog({
    super.key,
  });

  @override
  State<SearchUserDialog> createState() => _SearchUserDialogState();
}

class _SearchUserDialogState extends State<SearchUserDialog> {
  TextEditingController accountNumberController =
      TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 1);

  final FocusNode focusNode = FocusNode();

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
        title: const Text('Informacion de Usuario'),
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
          ActionButton(
            lable: 'Buscar',
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => InfoUserDialog(),
              );
            },
          ),
          ActionButton(
            lable: 'Cerrar',
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
