// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';
import 'package:unica_cybercoffee/services/API/api_connection.dart';

class LinkComputerLabCodePage extends StatefulWidget {
  const LinkComputerLabCodePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LinkComputerLabCodePageState createState() =>
      _LinkComputerLabCodePageState();
}

class _LinkComputerLabCodePageState extends State<LinkComputerLabCodePage> {
  TextEditingController codeController = TextEditingController(text: '');
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
                'Se envio un Codigo de verificacion al Administrador del Sistema comunicate con el y solicitacelo',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            CustomTextFileds(
              focusNode: focusNode,
              indexTextField: 0,
              textEditingController: codeController,
              maskController: maskController,
              lable: 'Code',
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 3, vertical: 16.0),
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
                onPressed: onLinkComputerLabConfirm,
                child: const Text(
                  'Crear Nueva Sala',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onLinkComputerLabConfirm() async {
    var response = await api.computerLabs
        .linkComputerLabConfirm(codeController.text, dataStatic.userName);
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

      //context.go('/link-computer-lab-code');
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
