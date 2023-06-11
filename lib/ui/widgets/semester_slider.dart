import 'package:flutter/material.dart';

class SemesterSlider extends StatefulWidget {
  @override
  _SemesterSliderState createState() => _SemesterSliderState();
}

class _SemesterSliderState extends State<SemesterSlider> {
  double _currentSemester = 1;

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 1,
      max: 10,
      divisions: 7,
      value: _currentSemester,
      onChanged: (value) {
        setState(() {
          _currentSemester = value;
        });
      },
      label: _currentSemester.toInt().toString(),
      activeColor: Colors.blue,
      inactiveColor: Color.fromARGB(165, 33, 149, 243),
    );
  }
}
