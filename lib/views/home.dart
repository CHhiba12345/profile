// home.dart
import 'package:flutter/material.dart';
import '../controller.dart';
import 'profile.dart';

class HomeController extends StatelessWidget {
  final UserController _userController = UserController();
//final rend _userController "fixe" pour éviter toute confusion et erreur de manipulation accidentelle.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profil'),
      ),
      body: Stack(
        //Dispose les éléments en couches
        fit: StackFit.expand,
        //le Stack occupera tout l'espace disponible dans son parent.
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
                  'Welcome to my profile',
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
                  child: Text('View Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
