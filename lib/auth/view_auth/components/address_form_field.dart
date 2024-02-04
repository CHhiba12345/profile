import 'package:flutter/material.dart';

class AddressFormField extends StatelessWidget {
  const AddressFormField({
    Key? key,
    required this.addressController,
    required this.outlineInputBorder,
  }) : super(key: key);

  final TextEditingController addressController;
  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: TextFormField(
        controller: addressController,
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          hintText: "Adresse",
          contentPadding: const EdgeInsets.all(
            15,
          ),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          fillColor: const Color.fromARGB(213, 250, 242, 250),
          filled: true,
        ),
      ),
    );
  }
}
