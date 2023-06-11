import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/main.dart';
import 'package:unica_cybercoffee/ui/providers/theme_provider.dart';

class TextMaskController extends ChangeNotifier {
  late List<bool> mask;
  TextMaskController({lengthMask}) {
    mask = [];
    for (int i = 0; i < lengthMask; i++) {
      mask.add(false);
    }
  }
  resetMask() {
    mask.fillRange(0, mask.length, false);
    notifyListeners();
  }

  updateMask(int index) {
    mask.fillRange(0, mask.length, false);
    mask[index] = true;
    notifyListeners();
  }
}

class CustomTextFileds extends StatefulWidget {
  const CustomTextFileds({
    required this.maskController,
    required this.indexTextField,
    super.key,
    required this.textEditingController,
    required this.lable,
    required this.padding,
    this.focusNode,
    this.onlyNumbers = false,
  });
  final TextMaskController maskController;
  final TextEditingController textEditingController;
  final int indexTextField;
  final String lable;
  final EdgeInsets padding;
  final bool onlyNumbers;
  final FocusNode? focusNode;
  @override
  CustomTextFiledsState createState() => CustomTextFiledsState();
}

class CustomTextFiledsState extends State<CustomTextFileds> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: widget.padding,
      child: Material(
        elevation: widget.maskController.mask[widget.indexTextField] == true
            ? 20.0
            : 0.0,
        shadowColor: widget.maskController.mask[widget.indexTextField] == true
            ? Colors.blueAccent
            : Colors.transparent,
        child: TextField(
          keyboardType: widget.onlyNumbers ? TextInputType.number : null,
          inputFormatters: widget.onlyNumbers
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          cursorColor: Theme.of(context).colorScheme.onPrimary,
          obscureText: widget.lable.toLowerCase() == 'password' ||
              widget.lable.toLowerCase() == 'contraseña',
          controller: widget.textEditingController,
          onTap: () => setState(
            () {
              widget.maskController.updateMask(widget.indexTextField);
            },
          ),
          selectionControls: DesktopTextSelectionControls(),
          decoration: InputDecoration(
            fillColor: currentTheme.isDarkTheme()
                ? const Color.fromARGB(54, 86, 96, 202)
                : const Color.fromARGB(255, 205, 206, 208),
            filled: true,
            labelText: widget.lable,
            labelStyle: TextStyle(
                color: widget.maskController.mask[widget.indexTextField] == true
                    ? Colors.blue
                    : Theme.of(context).colorScheme.onPrimary),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: widget.maskController.mask[widget.indexTextField] == true
                    ? Colors.blueAccent
                    : Colors.transparent,
              ),
            ),
            hintText: ' ${widget.lable}',
          ),
        ),
      ),
    );
  }
}
