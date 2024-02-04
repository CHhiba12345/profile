// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';
import 'package:profile/auth/controller_auth/auth_controller.dart';
import 'package:profile/auth/view_auth/components/avatar_profile_login.dart';
import 'package:profile/auth/view_auth/components/email_form_field.dart';
import 'package:profile/auth/view_auth/components/login_button.dart';
import 'package:profile/auth/view_auth/components/password_form_field.dart';
import 'package:profile/auth/view_auth/sign_up_page.dart/sign_page.dart';
import 'package:profile/di/get_di.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    controller = getItInstance();
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
              const SizedBox(
                height: 100,
              ),
              EmailFormField(
                usernameController: usernameController,
                outlineInputBorder: outlineInputBorder,
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordFormField(
                passwordController: passwordController,
                showPassword: showPassword,
                outlineInputBorder: outlineInputBorder,
                onPressed: () {
                  showPass();
                },
              ),
              const SizedBox(height: 50),
              LoginButton(
                title: "Se connecter",
                color: Colors.white,
                textColor: const Color.fromRGBO(119, 107, 169, 0.672),
                onPressed: () {
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
                color: const Color.fromARGB(255, 82, 72, 123),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SignUpPage(), // Assurez-vous d'avoir une classe SignUpPage
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
