import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    super.key,
    required this.usernameController,
    required this.outlineInputBorder,
  });

  final TextEditingController usernameController;
  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //définit un espace vide autour du contenu
      child: TextFormField(
        controller: usernameController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        validator: (value) {
          return null;
        },
        decoration: const InputDecoration(
          hintText: "Email",
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          contentPadding: EdgeInsets.all(
            15,
          ),
          fillColor: Color.fromRGBO(254, 235, 255, 0.906),
          filled: true,
          //Indique si le widget doit être rempli avec la couleur définie par fillColor
        ),
      ),
    );
  }
}
