// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profile/auth/controller_auth/auth_controller.dart';
import 'package:profile/auth/view_auth/sign_in_page/components/avatar_profile_login.dart';
import 'package:profile/auth/view_auth/sign_in_page/components/email_form_field.dart';
import 'package:profile/auth/view_auth/sign_in_page/components/login_button.dart';
import 'package:profile/auth/view_auth/sign_in_page/components/password_form_field.dart';
import '../../../../views/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ///------------- declaration + initialisation----------------///
  late FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late AuthController controller;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  void showPass() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void initState() {
    controller = AuthController(_auth, _firestore);
    print("=========creation de controller==================");
    usernameController.text = "chaoualihiba25@gmail.com";
    passwordController.text = "123456";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
    );
    return Scaffold(
      body: Form(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/welcome_image.jpeg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AvatarProfileLogin(),
              const SizedBox(height: 20),
              EmailFormField(
                usernameController: usernameController,
                outlineInputBorder: outlineInputBorder,
              ),
              PasswordFormField(
                passwordController: passwordController,
                showPassword: showPassword,
                outlineInputBorder: outlineInputBorder,
                onPressed: () {
                  showPass();
                },
              ),
              const SizedBox(height: 20),
              LoginButton(
                title: "Se connecter",
                color: Colors.white,
                textColor: const Color.fromRGBO(119, 107, 169, 0.672),
                onPressed: () {
                  // authenticateUser();
                  print("=========button connecter==========");
                  controller.authenticateUser(
                    context,
                    usernameController.text,
                    passwordController.text,
                  );
                },
              ),
              const SizedBox(height: 10),
              LoginButton(
                title: "S'inscrire",
                color: const Color.fromRGBO(119, 107, 169, 0.672),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SignUpPage(), // Assurez-vous d'avoir une classe SignUpPage
                    ),
                  );
                  // authenticateUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
