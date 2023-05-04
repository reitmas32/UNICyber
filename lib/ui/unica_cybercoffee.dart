import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unica_cybercoffee/ui/pages/computers_page.dart';
import 'package:unica_cybercoffee/ui/pages/login_page.dart';
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
        path: "/login",
        builder: (context, state) => const LoginPage(
          title: 'Home',
        ),
      ),
      GoRoute(
        path: "/computers",
        builder: (context, state) => ComputersPage(),
      ),
    ],
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
      themeMode: ThemeMode.system,
    );
  }
}
