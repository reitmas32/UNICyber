import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/ui/widgets/action_button.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_tab_view.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';

class InfoUserDialog extends StatefulWidget {
  InfoUserDialog({
    super.key,
  });

  @override
  State<InfoUserDialog> createState() => _InfoUserDialogState();
}

class _InfoUserDialogState extends State<InfoUserDialog> {
  List<String> tabs = [
    'Informacion',
    'Prestamo',
    'IMpresion',
    'Sancion',
    'Notificación'
  ];

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          //widget.onTap();
        }
      },
      child: AlertDialog(
        title: const Text('Usuario Encontrado'),
        content: Container(
          width: 600,
          height: 500,
          padding: const EdgeInsets.all(8.0),
          child: CustomTabView(
            itemCount: 5,
            tabBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${tabs[index]}',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            pageBuilder: (context, index) => Text('${tabs[index]}'),
          ),
        ),
        actions: [
          ActionButton(
            lable: 'Sancionar',
            onTap: () => Navigator.of(context).pop(),
          ),
          ActionButton(
            lable: 'Notificar',
            onTap: () => Navigator.of(context).pop(),
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
