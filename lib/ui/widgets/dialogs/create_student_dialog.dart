import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/domain/models/student.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/ui/widgets/action_button.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';
import 'package:unica_cybercoffee/ui/widgets/drop_menu_custom.dart';
import 'package:unica_cybercoffee/ui/widgets/semester_slider.dart';

// ignore: must_be_immutable
class CreateStudentDialog extends StatefulWidget {
  CreateStudentDialog({
    super.key,
    required this.student,
  });

  Student student;

  @override
  State<CreateStudentDialog> createState() => _CreateStudentDialogState();
}

class _CreateStudentDialogState extends State<CreateStudentDialog> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController universityProgramController =
      TextEditingController(text: '');
  TextEditingController accountNumberController =
      TextEditingController(text: '');
  TextEditingController semesterController = TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 7);
  final FocusNode focusNode = FocusNode();
  DropMenuController dropMenuController = DropMenuController();

  @override
  void initState() {
    maskController.addListener(() {
      setState(() {});
    });
    dropMenuController.addListener(() {
      setState(() {});
    });
    setState(() {
      maskController.updateMask(0);
      focusNode.requestFocus();
      accountNumberController.text = widget.student.accountNumber;
    });
    nameController.addListener(() {
      _convertToUppercase(nameController);
    });
    lastNameController.addListener(() {
      _convertToUppercase(lastNameController);
    });

    super.initState();
  }

  void _convertToUppercase(TextEditingController textEditingController) {
    final text = textEditingController.text.toUpperCase();
    textEditingController.value = textEditingController.value.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          //widget.onTap();
        }
      },
      child: AlertDialog(
        title: const Center(child: Text('Alta de Estudiante')),
        content: Container(
            width: 600,
            height: 650,
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFileds(
                    focusNode: focusNode,
                    autofocus: true,
                    indexTextField: 0,
                    textEditingController: nameController,
                    maskController: maskController,
                    lable: 'Nombre',
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: size.width / 10,
                    ),
                  ),
                  CustomTextFileds(
                    indexTextField: 0,
                    textEditingController: lastNameController,
                    maskController: maskController,
                    lable: 'Apellidos',
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: size.width / 10,
                    ),
                  ),
                  CustomTextFileds(
                    indexTextField: 0,
                    textEditingController: emailController,
                    maskController: maskController,
                    lable: 'Correo',
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: size.width / 10,
                    ),
                  ),
                  CustomTextFileds(
                    indexTextField: 0,
                    textEditingController: universityProgramController,
                    maskController: maskController,
                    lable: 'Carrera',
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: size.width / 10,
                    ),
                  ),
                  CustomTextFileds(
                    indexTextField: 0,
                    onlyNumbers: true,
                    textEditingController: accountNumberController,
                    maskController: maskController,
                    lable: 'Numero de Cuenta',
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: size.width / 10,
                    ),
                  ),
                  DropdownMenuCustom(
                    onChanged: (int index) {
                      print(index);
                    },
                    controller: dropMenuController,
                    items: dataStatic.universityPrograms
                        .map((universityProgram) => universityProgram.name)
                        .toList(),
                  ),
                  const SizedBox(
                    height: 80.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Semestre',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SemesterSlider(),
                ],
              ),
            )),
        actions: [
          ActionButton(
            lable: 'Confirmar',
            onTap: () {
              print(dataStatic
                  .universityPrograms[dropMenuController.currentSelected]);
              //Navigator.of(context).pop()
            },
          ),
          ActionButton(
            lable: 'Cancelar',
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
