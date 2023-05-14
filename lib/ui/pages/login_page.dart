import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:unica_cybercoffee/services/DB/database_static.dart';
import 'package:unica_cybercoffee/ui/widgets/appbar/unicaAppBar.dart';
import 'package:unica_cybercoffee/ui/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            onLogin();
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
                  onPressed: onLogin,
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
                  onPressed: onSignin,
                  child: const Text(
                    'New User? Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onLogin() async {
    if (await databaseStatic.signinUserAdmin(
        userNameController.text, passwordController.text)) {
      // ignore: use_build_context_synchronously
      context.go('/computers');
    } else {
      setState(() {
        errorLogin = true;
      });
    }
  }

  onSignin() {
    context.go('/signin');
  }
}
