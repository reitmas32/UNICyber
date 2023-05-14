import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/domain/models/computerUI.dart';
import 'package:unica_cybercoffee/domain/models/computer_states.dart';
import 'package:unica_cybercoffee/services/DB/databaseUI_static.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/computer_info_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/computer_view.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/loan_computer_dialog.dart';

class ComputerWidget extends StatefulWidget {
  const ComputerWidget({super.key, required this.computer});

  final ComputerUI computer;

  @override
  State<ComputerWidget> createState() => _ComputerWidgetState();
}

class _ComputerWidgetState extends State<ComputerWidget> {
  String _imageUrl =
      'https://em-content.zobj.net/source/microsoft-teams/337/desktop-computer_1f5a5-fe0f.png';

  String _imageUrlDisponible =
      'https://em-content.zobj.net/source/microsoft-teams/337/desktop-computer_1f5a5-fe0f.png';
  String _imageUrlReparacion =
      'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/desktop-computer-reparacion.png';
  String _imageUrlProyecto =
      'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/desktop-computer-proyecto.png';
  String _imageUrlMantenimiento =
      'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/desktop-computer-mantenimiento.png';

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
              child: LoanComputerDialog(),
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
                  computerUI: widget.computer,
                ),
              ),
            ),
          );

          setState(() {
            var state = widget.computer.state;
            if(result != null){
            databaseUI_Static.setStateComputer(widget.computer.id, ComputerStates.getStateLable(result['state']));
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
          imageUrl: widget.computer.imageUrl,
        ),
      ),
    );
  }
}
