import 'package:flutter/material.dart';
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/ui/widgets/computer_widget.dart';

class TableComputers extends StatefulWidget {
  const TableComputers({super.key, required this.computers});
  final List<Computer> computers;

  @override
  State<TableComputers> createState() => _TableComputersState();
}

class _TableComputersState extends State<TableComputers> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulación de una operación que tarda 2 segundos en completarse
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  List<Widget> getComputers() {
    List<Widget> computerView = [];

    for (var computer in widget.computers) {
      computerView.add(ComputerWidget(computer: computer));
    }
    return computerView;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : Stack(
            children: getComputers(),
          );
  }
}
