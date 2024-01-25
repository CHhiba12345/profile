// splashscreen.dart
import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  //Ce mot-clé indique que la méthode suivante est en train de surcharger une méthode existante dans la classe parente.
  _SplashScreenState createState() => _SplashScreenState();
  //Elle est utilisée pour créer et retourner l'état associé au widget.
//Cette instance de State est ensuite utilisée pour stocker et gérer l'état mutable du widget.
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeController(),
          //responsable de la création et du retour des widgets à afficher à l'écran.
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red,
      // widget de base qui fournit une structure générale pour une application Flutter
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
