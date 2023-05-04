import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unica_cybercoffee/domain/models/position.dart';

class TableComputers extends StatefulWidget {
  const TableComputers({super.key, required this.computers});
  final List<Position> computers;

  @override
  State<TableComputers> createState() => _TableComputersState();
}

class _TableComputersState extends State<TableComputers> {
  List<Widget> getComputers() {
    List<Widget> computerView = [];

    for (var computer in widget.computers) {
      computerView.add(ComputerView(pos: computer));
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
  const ComputerView({super.key, required this.pos});

  final Position pos;

  @override
  State<ComputerView> createState() => _ComputerViewState();
}

class _ComputerViewState extends State<ComputerView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.pos.x,
      top: widget.pos.y,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            widget.pos.x += details.delta.dx;
            widget.pos.y += details.delta.dy;
          });
        },
        child: Container(
          width: 100,
          height: 100,
          child: Image.network(
            'https://em-content.zobj.net/source/microsoft-teams/337/desktop-computer_1f5a5-fe0f.png',
          ),
        ),
      ),
    );
  }
}
