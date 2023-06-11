import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/domain/models/student.dart';
import 'package:unica_cybercoffee/services/API/api_connection.dart';
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
  TextEditingController accountNumberController =
      TextEditingController(text: '');
  TextEditingController semesterController = TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 7);
  final FocusNode focusNode = FocusNode();
  DropMenuController universityProgramController = DropMenuController();
  SemesterSliderController semesterSliderController =
      SemesterSliderController();

  @override
  void initState() {
    maskController.addListener(() {
      setState(() {});
    });
    universityProgramController.addListener(() {
      setState(() {});
    });
    semesterSliderController.addListener(() {
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
            height: 550,
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFileds(
                    width: 350,
                    autofocus: true,
                    indexTextField: 0,
                    textEditingController: nameController,
                    maskController: maskController,
                    lable: 'Nombre',
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                  ),
                  CustomTextFileds(
                    indexTextField: 0,
                    textEditingController: lastNameController,
                    maskController: maskController,
                    lable: 'Apellidos',
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    width: 350,
                  ),
                  CustomTextFileds(
                    indexTextField: 0,
                    textEditingController: emailController,
                    maskController: maskController,
                    lable: 'Correo',
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    width: 350,
                  ),
                  CustomTextFileds(
                    indexTextField: 0,
                    onlyNumbers: true,
                    textEditingController: accountNumberController,
                    maskController: maskController,
                    lable: 'Numero de Cuenta',
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    width: 350,
                  ),
                  DropdownMenuCustom(
                    onChanged: (value) {},
                    controller: universityProgramController,
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
                  SemesterSlider(
                    controller: semesterSliderController,
                  ),
                ],
              ),
            )),
        actions: [
          ActionButton(lable: 'Confirmar', onTap: onConfirm),
          ActionButton(
            lable: 'Cancelar',
            onTap: onCancel,
          ),
        ],
      ),
    );
  }

  onCancel() {
    Navigator.of(context).pop();
  }

  onConfirm() async {
    var student = Student(
      name: nameController.text,
      accountNumber: accountNumberController.text,
      email: emailController.text,
      lastName: lastNameController.text,
      semester: semesterSliderController.currentSelected,
      idUniversityProgram: dataStatic
          .universityPrograms[universityProgramController.currentSelected].id,
    );
    var result = await api.students.createStudent(student);
    if (result.isNotEmpty()) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            'Estudiante registrado Corectamente 👌',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 2), // Duración del SnackBar
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No se Pudo registrar al Estudiante 😢',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 2), // Duración del SnackBar
        ),
      );
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
