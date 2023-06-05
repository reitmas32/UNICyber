// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';
import 'package:unica_cybercoffee/services/API/computer_lab.dart'
    as computer_lab;
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/domain/models/computer_lab.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';

class LinkComputerLabPage extends StatefulWidget {
  const LinkComputerLabPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LinkComputerLabPageState createState() => _LinkComputerLabPageState();
}

class _LinkComputerLabPageState extends State<LinkComputerLabPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 2);
  RadioButtonGroupController<ComputerLab> radioButtonGroupController =
      RadioButtonGroupController(
    selectedOption: ComputerLab(),
  );

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    onGetComputerLabs();
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
    Size size = MediaQuery.of(context).size;
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
            CustomTextFileds(
              focusNode: focusNode,
              indexTextField: 0,
              textEditingController: nameController,
              maskController: maskController,
              lable: 'Nombre de usuario',
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 3, vertical: 16.0),
            ),
            const SizedBox(
              height: 130,
            ),
            Center(
              child: FutureBuilder(
                future: dataStatic.allComputerLabs.isEmpty
                    ? Future.delayed(const Duration(milliseconds: 500))
                    : Future.delayed(const Duration(milliseconds: 0)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Muestra el CircularProgressIndicator mientras espera
                    return const CircularProgressIndicator(
                      color: Colors.blue,
                    );
                  } else {
                    // Renderiza el widget deseado después de 2 segundos
                    return Column(
                      children: [
                        RadioButtonGroup(
                          controller: radioButtonGroupController,
                          data: dataStatic.allComputerLabs,
                        ),
                        Text(
                          'Seleccionaste la: ${radioButtonGroupController.selectedOption.name}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 130,
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: onLinkComputerLab,
                            child: const Text(
                              'Crear Nueva Sala',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onLinkComputerLab() async {
    var response = await computer_lab.linkComputerLab(
        radioButtonGroupController.selectedOption, nameController.text);
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

  onGetComputerLabs() async {
    var response = computer_lab.getComputerLabs();
  }
}

class RadioButtonGroupController<T> extends ChangeNotifier {
  late T selectedOption;
  RadioButtonGroupController({required this.selectedOption});
  setOption(T value) {
    selectedOption = value;
    notifyListeners();
  }
}

class RadioButtonGroup<T> extends StatefulWidget {
  RadioButtonGroupController<T> controller;
  List<T> data;

  RadioButtonGroup({super.key, required this.controller, required this.data});

  @override
  _RadioButtonGroupState<T> createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState<T> extends State<RadioButtonGroup> {
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
