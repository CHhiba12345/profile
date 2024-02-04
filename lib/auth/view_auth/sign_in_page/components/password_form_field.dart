import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField(
      {super.key,
      required this.passwordController,
      required this.showPassword,
      required this.outlineInputBorder,
      this.onPressed});

  final TextEditingController passwordController;
  final bool showPassword;
  final OutlineInputBorder outlineInputBorder;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: passwordController,
        obscureText: showPassword,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: "Mot de passe",
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          contentPadding: const EdgeInsets.all(
            15,
          ),
          fillColor: const Color.fromRGBO(255, 242, 255, 0.804),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          filled: true,
        ),
      ),
    );
  }
}
