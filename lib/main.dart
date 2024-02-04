// main.dart
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:profile/di/get_di.dart' as getIt;
import 'package:profile/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Assurez-vous que Firebase est initialisé avec les options spécifiées
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await getIt.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Splash Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
