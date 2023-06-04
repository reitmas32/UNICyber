import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:unica_cybercoffee/domain/models/user.dart';
import 'package:unica_cybercoffee/services/API/data_static.dart';
import 'package:unica_cybercoffee/services/DB/database_static.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';

import 'package:unica_cybercoffee/services/API/account.dart' as accounts;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextMaskController maskController = TextMaskController(lengthMask: 2);
  bool errorLogin = false;
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
            onSignIn();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: Image.network(
                        'https://raw.githubusercontent.com/reitmas32/unica_cybercoffee/main/public/assets/unica_logo.jpeg'),
                  ),
                ),
              ),
              CustomTextFileds(
                focusNode: focusNode,
                indexTextField: 0,
                textEditingController: userNameController,
                maskController: maskController,
                lable: 'UserName',
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 3, vertical: 16.0),
              ),
              CustomTextFileds(
                indexTextField: 1,
                textEditingController: passwordController,
                maskController: maskController,
                lable: 'Password',
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 3, vertical: 16.0),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: onSignIn,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              if (errorLogin)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Text(
                    'Error Login',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: onSignUp,
                  child: const Text(
                    'New User? Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        backgroundColor: Colors.blue,
        child: const Tooltip(
          message: 'Tutorial App',
          child: Icon(
            Icons.computer,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  onSignIn() async {
    User user = User(
      name: userNameController.text,
      password: passwordController.text,
      userName: userNameController.text,
    );

    var response = await accounts.signIn(user);
    if (response) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            'Se inicio secion Corectamente 👌',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 2), // Duración del SnackBar
        ),
      );
      // ignore: use_build_context_synchronously
      context.go('/computers');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No se pudo inicirar sesion 😢',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 2), // Duración del SnackBar
        ),
      );
    }
  }

  onSignUp() {
    context.go('/signup');
  }

  onCreateNewComputerLab() {
    context.go('/newComputerLab');
  }
}
