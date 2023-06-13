import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/providers/theme_provider.dart';
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
    final editableProvider = Provider.of<EditableUIProvider>(context);
    List<Widget> computerView = [];
    if (editableProvider.editable) {
      computerView.add(LineGuide());
    }
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

class LineGuide extends StatelessWidget {
  const LineGuide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);

    return CustomPaint(
      painter: TablePainter(
          lineSpacing: 50.0, columnSpacing: 50.0, themeProvider: currentTheme),
      child: Container(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class TablePainter extends CustomPainter {
  final double lineSpacing;
  final double columnSpacing;
  final ThemeProvider themeProvider;

  TablePainter(
      {required this.lineSpacing,
      required this.columnSpacing,
      required this.themeProvider});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = themeProvider.isDarkTheme() ? Colors.white : Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Líneas horizontales
    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Líneas verticales
    for (double x = 0; x < size.width; x += columnSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
