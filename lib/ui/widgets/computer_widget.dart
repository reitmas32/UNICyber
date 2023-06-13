import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/computer_info_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/computer_view.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/loan_computer_dialog.dart';
import 'package:unica_cybercoffee/services/API/api_connection.dart';

// ignore: must_be_immutable
class ComputerWidget extends StatefulWidget {
  ComputerWidget({super.key, required this.computer});

  Computer computer;

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
            builder: (context) => ComputerInfoDialog(
              computer: widget.computer,
            ),
          );
          if (result != null) {
            //await computer.updateComputer(result);
            setState(() {
              //widget.computer = result;
            });
          }
        },
        onPanUpdate: (details) {
          if (editableProvider.editable) {
            setState(() {
              widget.computer.x += details.delta.dx;
              widget.computer.y += details.delta.dy;
            });
          }
        },
        onPanEnd: (details) async {
          if (editableProvider.editable) {
            setState(() {
              widget.computer.x = (widget.computer.x / 50).round() * 50;
              widget.computer.y = (widget.computer.y / 50).round() * 50;
            });
            await api.computers.updateComputer(widget.computer);
          }
        },
        child: ComputerView(
          name: widget.computer.name,
          imageUrl: dataStatic.states
              .toList()
              .firstWhere((element) => element.id == widget.computer.idState)
              .img,
        ),
      ),
    );
  }
}
