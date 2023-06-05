import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unica_cybercoffee/ui/pages/computers_page.dart';
import 'package:unica_cybercoffee/ui/pages/error_page.dart';
import 'package:unica_cybercoffee/ui/pages/link_computer_lab_page.dart';
import 'package:unica_cybercoffee/ui/pages/signin_page.dart';
import 'package:unica_cybercoffee/ui/pages/new_computer_lab_page.dart';
import 'package:unica_cybercoffee/ui/pages/signup_page.dart';
import 'package:unica_cybercoffee/ui/pages/splash_page/splash_page.dart';
import 'package:unica_cybercoffee/ui/providers/theme_provider.dart';
import 'package:unica_cybercoffee/ui/theme_preference.dart';
import 'package:provider/provider.dart';

class UnicaCyberCoffe extends StatefulWidget {
  const UnicaCyberCoffe({
    super.key,
  });

  @override
  State<UnicaCyberCoffe> createState() => UnicaCyberCoffeState();
}

class UnicaCyberCoffeState extends State<UnicaCyberCoffe> {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/signin",
        builder: (context, state) => const SignInPage(
          title: 'Home',
        ),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => const SignUpPage(
          title: 'Home',
        ),
      ),
      GoRoute(
        path: "/computers",
        builder: (context, state) => const ComputersPage(),
      ),
      GoRoute(
        path: "/newComputerLab",
        builder: (context, state) => const NewComputerLabPage(),
      ),
      GoRoute(
        path: "/linkComputerLab",
        builder: (context, state) => const LinkComputerLabPage(),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme:
          currentTheme.isDarkTheme() ? AppTheme.darkTheme : AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
