import 'package:flutter/material.dart';
import '../../../../views/home.dart';
import '../../../../views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController usernameController = TextEditingController();
  // gérer la saisie de texte dans les champs de formulaire.
  //Contrôleur pour le champ de saisie de l'adresse
  TextEditingController passwordController = TextEditingController();

  void authenticateUser() async {
    String username = usernameController.text;
    String password = passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      // Récupérez les informations de l'utilisateur depuis Firestore.
      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // Utilisez les données récupérées comme nécessaire.
      String userEmail = userSnapshot['email'];
      String userAddress = userSnapshot['address'];
      String userPhoneNumber = userSnapshot['phoneNumber'];

      // Si l'authentification est réussie, redirigez l'utilisateur vers la page d'accueil.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeController(email: userCredential.user!.email!),
        ),
      );
    } catch (e) {
      showErrorMessage("Erreur d'authentification : ${e.toString()}");
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      //utilisée pour afficher des SnackBars
      //snackBar:une petite barre qui apparaît en bas de l'écran
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    usernameController.text = "chaoualihiba25@gmail.com";
    passwordController.text = "123456";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/welcome_image.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/profile_picture.jpeg"),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                //définit un espace vide autour du contenu
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    //Indique si le widget doit être rempli avec la couleur définie par fillColor
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Mot de passe",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  authenticateUser(); // Appeler la fonction d'authentification
                },
                child: const Text("Se connecter"),
              ),
              const SizedBox(height: 10), // Espace entre les boutons
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SignUpPage(), // Assurez-vous d'avoir une classe SignUpPage
                    ),
                  );
                },
                child: const Text("S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
