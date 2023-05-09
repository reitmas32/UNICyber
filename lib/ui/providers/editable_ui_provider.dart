import 'package:flutter/material.dart';

class EditableUIProvider with ChangeNotifier {
  bool _editable = false;

  bool get editable => _editable;

  seteditable() {
    _editable = !_editable;
    notifyListeners();
  }

}