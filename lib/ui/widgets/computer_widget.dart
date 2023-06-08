import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/domain/models/computer_states.dart';
import 'package:unica_cybercoffee/services/DB/database_ui_static.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/computer_info_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/computer_view.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/loan_computer_dialog.dart';

class ComputerWidget extends StatefulWidget {
  const ComputerWidget({super.key, required this.computer});

  final Computer computer;

  @override
  State<ComputerWidget> createState() => _ComputerWidgetState();
}

class _ComputerWidgetState extends State<ComputerWidget> {
  @override
  Widget build(BuildContext context) {
    final editableProvider = Provider.of<EditableUIProvider>(context);

    return Positioned(
      left: widget.computer.x,
      top: widget.computer.y,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => RawKeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKey: (RawKeyEvent event) {
                if (event.logicalKey == LogicalKeyboardKey.enter) {
                  Navigator.pop(context);
                }
              },
              child: const LoanComputerDialog(),
            ),
          );
        },
        onSecondaryTap: () async {
          var result = await showDialog(
            context: context,
            builder: (context) => RawKeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKey: (RawKeyEvent event) {
                if (event.logicalKey == LogicalKeyboardKey.enter) {
                  Navigator.pop(context);
                }
              },
              child: WillPopScope(
                onWillPop: () async {
                  Navigator.of(context).pop(); //Cerrar el AlertDialog
                  return true;
                },
                child: ComputerInfoDialog(
                  computer: widget.computer,
                ),
              ),
            ),
          );

          setState(() {
            if (result != null) {
              databaseUIStatic.setStateComputer('widget.computer.id',
                  ComputerStates.getStateLable(result['state']));
            }
          });
        },
        onPanUpdate: (details) {
          if (editableProvider.editable) {
            setState(() {
              widget.computer.x += details.delta.dx;
              widget.computer.y += details.delta.dy;
            });
          }
        },
        child: ComputerView(
          name: widget.computer.name,
          imageUrl:
              'https://em-content.zobj.net/source/microsoft-teams/337/desktop-computer_1f5a5-fe0f.png',
        ),
      ),
    );
  }
}
