import 'package:flutter/material.dart';

class RadioButtonGroupController<T> extends ChangeNotifier {
  late T selectedOption;
  RadioButtonGroupController({required this.selectedOption});
  setOption(T value) {
    selectedOption = value;
    notifyListeners();
  }
}

// ignore: must_be_immutable
class RadioButtonGroup<T> extends StatefulWidget {
  RadioButtonGroupController<T> controller;
  List<T> data;

  RadioButtonGroup({super.key, required this.controller, required this.data});

  @override
  RadioButtonGroupState<T> createState() => RadioButtonGroupState();
}

class RadioButtonGroupState<T> extends State<RadioButtonGroup> {
  @override
  void initState() {
    super.initState();
    // Aquí realizarías la petición a la API y asignarías la respuesta a 'widget.data'
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Selecciona un elemento:',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        if (widget.data.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3),
            child: Column(
              children: widget.data
                  .map(
                    (option) => RadioListTile(
                      title: Text(option.name),
                      value: option,
                      groupValue: widget.controller.selectedOption,
                      onChanged: (value) {
                        setState(() {
                          widget.controller.setOption(value);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
