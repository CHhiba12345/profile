import 'package:flutter/material.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({
    Key? key,
    required this.outlineInputBorder,
    required this.phoneNumberController,
  }) : super(key: key);
  final OutlineInputBorder outlineInputBorder;
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: phoneNumberController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "merci de saisir votre numero";
          } else if (value.length < 8 || value.length > 8) {
            return "numero de telephone invalide";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: "Numéro de téléphone",
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          contentPadding: const EdgeInsets.all(
            15,
          ),
          fillColor: const Color.fromARGB(213, 250, 242, 250),
          filled: true,
        ),
      ),
    );
  }
}
