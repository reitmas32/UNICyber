import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unica_cybercoffee/services/API/api_connection.dart';
import 'package:unica_cybercoffee/ui/widgets/action_button.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/create_student_dialog.dart';
import 'package:unica_cybercoffee/ui/widgets/dialogs/info_student_dialog.dart';

class SearchUserDialog extends StatefulWidget {
  const SearchUserDialog({
    super.key,
  });

  @override
  State<SearchUserDialog> createState() => _SearchUserDialogState();
}

class _SearchUserDialogState extends State<SearchUserDialog> {
  TextEditingController accountNumberController =
      TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 1);

  @override
  void initState() {
    maskController.addListener(() {
      setState(() {});
    });
    setState(() {
      maskController.updateMask(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      includeSemantics: true,
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          onSearch();
        }
      },
      child: AlertDialog(
        title: const Text('Informacion de Usuario'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFileds(
              onlyNumbers: true,
              autofocus: true,
              indexTextField: 0,
              textEditingController: accountNumberController,
              maskController: maskController,
              lable: 'AccountNumber',
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
          ],
        ),
        actions: [
          ActionButton(
            lable: 'Buscar',
            onTap: onSearch,
          ),
          ActionButton(
            lable: 'Cerrar',
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  onSearch() async {
    showDialog(
      context: context,
      builder: (context) => ProgressDialog(),
    );

    await Future.delayed(const Duration(milliseconds: 350));

    var newStudent =
        await api.students.getStudent(accountNumberController.text);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    if (newStudent.isNotEmpty()) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => InfoStudentDialog(
          student: newStudent,
        ),
      );
    } else {
      newStudent.accountNumber = accountNumberController.text;
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => CreateStudentDialog(
          student: newStudent,
        ),
      );
    }
  }
}

class ProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Informacion de Usuario'),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(
              color: Colors.blue,
            ),
            SizedBox(width: 16.0),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}
