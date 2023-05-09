import 'package:flutter/material.dart';
import 'package:unica_cybercoffee/domain/models/computerUI.dart';
import 'package:unica_cybercoffee/ui/widgets/computer_widget.dart';

class TableComputers extends StatefulWidget {
  const TableComputers({super.key, required this.computers});
  final List<ComputerUI> computers;

  @override
  State<TableComputers> createState() => _TableComputersState();
}

class _TableComputersState extends State<TableComputers> {
  List<Widget> getComputers() {
    List<Widget> computerView = [];

    for (var computer in widget.computers) {
      computerView.add(ComputerWidget(computer: computer));
    }
    return computerView;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: getComputers(),
    );
  }
}