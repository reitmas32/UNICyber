// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';
import 'package:unica_cybercoffee/services/API/computer_lab.dart'
    as computer_lab;
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';

class NewComputerLabPage extends StatefulWidget {
  const NewComputerLabPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewComputerLabPageState createState() => _NewComputerLabPageState();
}

class _NewComputerLabPageState extends State<NewComputerLabPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 2);

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    maskController.addListener(() {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const UnicaAppBar(route: '/'),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            onCreateNewComputerLab();
          }
        },
        child: SingleChildScrollView(
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
              CustomTextFileds(
                focusNode: focusNode,
                indexTextField: 0,
                textEditingController: nameController,
                maskController: maskController,
                lable: 'Nombre de la Sala',
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 3, vertical: 16.0),
              ),
              CustomTextFileds(
                indexTextField: 1,
                textEditingController: descriptionController,
                maskController: maskController,
                lable: 'Descripcion de la Sala',
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 3, vertical: 16.0),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: onCreateNewComputerLab,
                  child: const Text(
                    'Crear Nueva Sala',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onCreateNewComputerLab() async {
    ComputerLab computerLab = ComputerLab(
        name: nameController.text, description: descriptionController.text);

    var response = await computer_lab.createComputerLab(computerLab);
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            'Sala Creada Con exito 👌',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 2), // Duración del SnackBar
        ),
      );
      context.go('/signin');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No se pudo crear la Sala 😢',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 2), // Duración del SnackBar
        ),
      );
    }
  }
}
