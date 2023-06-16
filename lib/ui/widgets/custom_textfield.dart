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
  CustomTextFileds({
    required this.maskController,
    required this.indexTextField,
    super.key,
    required this.textEditingController,
    required this.lable,
    this.padding,
    this.focusNode,
    this.width,
    this.onlyNumbers = false,
    this.autofocus = false,
  });
  final TextMaskController maskController;
  final TextEditingController textEditingController;
  final int indexTextField;
  final String lable;
  final EdgeInsets? padding;
  final bool onlyNumbers;
  final bool autofocus;
  final FocusNode? focusNode;
  final double? width;
  @override
  CustomTextFiledsState createState() => CustomTextFiledsState();
}

class CustomTextFiledsState extends State<CustomTextFileds> {
  bool _obscureText = true;
  bool _isPasswordTextFiled = false;
  @override
  void initState() {
    _isPasswordTextFiled = widget.lable.toLowerCase() == 'password' ||
        widget.lable.toLowerCase() == 'contraseña';
    _obscureText = _isPasswordTextFiled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0.0),
      child: Container(
        width: widget.width ?? double.infinity,
        child: Material(
          elevation: widget.maskController.mask[widget.indexTextField] == true
              ? 20.0
              : 0.0,
          shadowColor: widget.maskController.mask[widget.indexTextField] == true
              ? Colors.blueAccent
              : Colors.transparent,
          child: TextField(
            autofocus: widget.autofocus,
            keyboardType: widget.onlyNumbers ? TextInputType.number : null,
            inputFormatters: widget.onlyNumbers
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            /*
            obscureText: widget.lable.toLowerCase() == 'password' ||
                widget.lable.toLowerCase() == 'contraseña',
                */
            obscureText: _obscureText,
            controller: widget.textEditingController,
            onTap: () => setState(
              () {
                widget.maskController.updateMask(widget.indexTextField);
              },
            ),
            selectionControls: DesktopTextSelectionControls(),
            decoration: InputDecoration(
              suffixIcon: _isPasswordTextFiled
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: _obscureText ? Colors.blue : const Color.fromARGB(255, 130, 176, 215),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              fillColor: currentTheme.isDarkTheme()
                  ? const Color.fromARGB(54, 86, 96, 202)
                  : const Color.fromARGB(255, 205, 206, 208),
              filled: true,
              labelText: widget.lable,
              labelStyle: TextStyle(
                  color:
                      widget.maskController.mask[widget.indexTextField] == true
                          ? Colors.blue
                          : Theme.of(context).colorScheme.onPrimary),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color:
                      widget.maskController.mask[widget.indexTextField] == true
                          ? Colors.blueAccent
                          : Colors.transparent,
                ),
              ),
              hintText: ' ${widget.lable}',
            ),
          ),
        ),
      ),
    );
  }
}
