import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unica_cybercoffee/domain/models/computerUI.dart';
import 'package:unica_cybercoffee/domain/models/position.dart';

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
      computerView.add(ComputerView(computer: computer));
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

class ComputerView extends StatefulWidget {
  const ComputerView({super.key, required this.computer});

  final ComputerUI computer;

  @override
  State<ComputerView> createState() => _ComputerViewState();
}

class _ComputerViewState extends State<ComputerView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.computer.x,
      top: widget.computer.y,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            widget.computer.x += details.delta.dx;
            widget.computer.y += details.delta.dy;
          });
        },
        child: Container(
          width: 100,
          height: 120,
          child: Column(
            children: [
              Text(widget.computer.name),
              Image.network(
                'https://em-content.zobj.net/source/microsoft-teams/337/desktop-computer_1f5a5-fe0f.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
