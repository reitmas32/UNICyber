import 'package:flutter/material.dart';

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
  const CustomTextFileds(
      {required this.maskController,
      required this.indexTextField,
      super.key,
      required this.textEditingController,
      required this.lable,
      required this.padding,
      this.focusNode});
  final TextMaskController maskController;
  final TextEditingController textEditingController;
  final int indexTextField;
  final String lable;
  final EdgeInsets padding;
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
          focusNode: widget.focusNode,
          controller: widget.textEditingController,
          onTap: () => setState(() {
            widget.maskController.updateMask(widget.indexTextField);
          }),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color:
                      widget.maskController.mask[widget.indexTextField] == true
                          ? Colors.blueAccent
                          : Colors.transparent,
                ),
              ),
              hintText: widget.lable),
        ),
      ),
    );
  }
}
