// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:profile/auth/view_auth/sign_in_page/sign_in_page.dart';

// Assurez-vous d'importer correctement la page de login

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginPage(), // Utilisez le nom correct de votre classe de page de login
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(),
      ),
    );
  }
}
