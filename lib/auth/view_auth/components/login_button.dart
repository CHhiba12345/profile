import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    this.onPressed,
    required this.title,
    required this.color,
    required this.textColor,
  }) : super(key: key);
  final void Function()? onPressed;
  final String title;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: 140,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          25,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
        ),
      ),
    );
  }
}
