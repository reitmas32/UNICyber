import 'package:flutter/material.dart';

class SemesterSlider extends StatefulWidget {
  final SemesterSliderController controller;

  const SemesterSlider({super.key, required this.controller});
  @override
  _SemesterSliderState createState() => _SemesterSliderState();
}

class _SemesterSliderState extends State<SemesterSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 1,
      max: 10,
      divisions: 9,
      value: widget.controller.currentSelected.toDouble(),
      onChanged: (value) {
        setState(() {
          widget.controller.updateMask(value.toInt());
        });
      },
      label: widget.controller.currentSelected.toString(),
      activeColor: Colors.blue,
      inactiveColor: Color.fromARGB(165, 33, 149, 243),
    );
  }
}

class SemesterSliderController extends ChangeNotifier {
  late int currentSelected;
  SemesterSliderController() {
    currentSelected = 1;
  }

  updateMask(int index) {
    if (index >= 0) {
      currentSelected = index;
      notifyListeners();
    }
  }
}
