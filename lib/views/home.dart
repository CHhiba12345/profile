import 'package:flutter/material.dart';
import '../controller.dart'; // Assurez-vous d'importer correctement votre fichier controller.dart
import 'profile.dart';

class HomeController extends StatefulWidget {
  final String email;

  HomeController({required this.email});

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/welcome_image.jpeg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_picture.jpeg'),
                ),
                SizedBox(height: 20),
                Text(
                  'welcome  ${widget.email}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(userController: _userController),
                      ),
                    );
                  },
                  child: Text('Voir le profil'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

