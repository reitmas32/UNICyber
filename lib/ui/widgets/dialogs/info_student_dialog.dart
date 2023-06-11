import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/domain/models/student.dart';
import 'package:unica_cybercoffee/ui/widgets/action_button.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_tab_view.dart';

class InfoStudentDialog extends StatefulWidget {
  InfoStudentDialog({
    super.key,
    required this.student,
  });

  Student student;

  @override
  State<InfoStudentDialog> createState() => _InfoStudentDialogState();
}

class _InfoStudentDialogState extends State<InfoStudentDialog> {
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
                tabs[index],
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            pageBuilder: (context, index) => Text(tabs[index]),
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
