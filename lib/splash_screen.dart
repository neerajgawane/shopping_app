import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: const Text(
        'Shopping App',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      nextScreen: const HomePage(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.blue,
      splashIconSize: 150,
    );
  }
}
