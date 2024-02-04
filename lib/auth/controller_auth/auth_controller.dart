import 'package:firebase_auth/firebase_auth.dart';
import 'package:profile/auth/model_auth/model_sign_in.dart';
import 'package:profile/auth/model_auth/model_sign_up.dart';
import 'package:profile/views/signup.dart';

/// +++++++++++++++++ Class [AuthController]++++++++++++++++++++++++
/// va contenir les methodes de sign-in & sign-up et on va injecter  le classe [FirebaseAuth]
/// ++++++++++++++++++++++++++ End ********************************
///
final auth = FirebaseAuth.instance;

class AuthController {
  final FirebaseAuth auth;

  AuthController(this.auth);

  static Future<void> authenticateUser(SignIn model) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
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
}
