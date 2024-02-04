// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:profile/auth/controller_auth/auth_controller.dart';
import 'package:profile/auth/view_auth/components/address_form_field.dart';
import 'package:profile/auth/view_auth/components/avatar_profile_login.dart';
import 'package:profile/auth/view_auth/components/email_form_field.dart';
import 'package:profile/auth/view_auth/components/login_button.dart';
import 'package:profile/auth/view_auth/components/password_form_field.dart';
import 'package:profile/auth/view_auth/components/phone_form_field.dart';
import 'package:profile/di/get_di.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late AuthController controller;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  void initState() {
    controller = getItInstance();
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Form(
        key: form,
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
              const AvatarProfileLogin(),
              const SizedBox(height: 70),
              EmailFormField(
                usernameController: emailController,
                outlineInputBorder: outlineInputBorder,
              ),
              const SizedBox(height: 10),
              PasswordFormField(
                passwordController: passwordController,
                showPassword: false,
                outlineInputBorder: outlineInputBorder,
              ),
              const SizedBox(height: 10),
              AddressFormField(
                addressController: addressController,
                outlineInputBorder: outlineInputBorder,
              ),
              const SizedBox(height: 10),
              PhoneFormField(
                phoneNumberController: phoneNumberController,
                outlineInputBorder: outlineInputBorder,
              ),
              const SizedBox(height: 60),
              LoginButton(
                title: "S'inscrire",
                color: const Color.fromARGB(255, 82, 72, 123),
                textColor: Colors.white,
                onPressed: () {
                  if (form.currentState!.validate()) {
                    controller.registerUser(
                      emailController.text,
                      passwordController.text,
                      addressController.text,
                      phoneNumberController.text,
                      context,
                    );
                  }
                  //registerUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
