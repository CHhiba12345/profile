// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profile/auth/model_auth/model_sign_in.dart';
import 'package:profile/auth/model_auth/model_sign_up.dart';
import 'package:profile/views/home.dart';
import 'package:profile/views/signup.dart';

/// +++++++++++++++++ Class [AuthController]++++++++++++++++++++++++
/// va contenir les methodes de sign-in & sign-up et on va injecter  le classe [FirebaseAuth]
/// ++++++++++++++++++++++++++ End ********************************
///

class AuthController {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthController(this.auth, this.firestore);

  Future<void> authenticateUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("=========retour depuis firebase==================");
      // Si l'authentification est réussie, redirigez l'utilisateur vers la page d'accueil.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomeController(email: userCredential.user!.email!),
        ),
      );
    } catch (e) {
      // showErrorMessage("Erreur d'authentification : ${e.toString()}");
      print("=========erreur  depuis firebase==================");
      ScaffoldMessenger.of(context).showSnackBar(
        //utilisée pour afficher des SnackBars
        //snackBar:une petite barre qui apparaît en bas de l'écran
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
