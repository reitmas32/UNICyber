// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';
import 'package:unica_cybercoffee/ui/widgets/radio_button_group.dart';

class SelectComputerLabPage extends StatefulWidget {
  const SelectComputerLabPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelectComputerLabPageState createState() => _SelectComputerLabPageState();
}

class _SelectComputerLabPageState extends State<SelectComputerLabPage> {
  TextEditingController codeController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 2);
  RadioButtonGroupController<ComputerLab> radioButtonGroupController =
      RadioButtonGroupController(
    selectedOption: ComputerLab(),
  );

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    maskController.addListener(() {
      setState(() {});
    });
    radioButtonGroupController.addListener(() {
      setState(() {});
    });
    setState(() {
      maskController.updateMask(0);
      focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UnicaAppBar(route: '/'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.network(
                      'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/unica_logo.jpeg'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Selecciona la sala a la que quieres Acceder',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            RadioButtonGroup(
              controller: radioButtonGroupController,
              data: dataStatic.allComputerLabs,
            ),
            const SizedBox(
              height: 130,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: onViewComputerLab,
                child: const Text(
                  'Ver Sala',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onViewComputerLab() {
    context.go('/computers');
  }
}
