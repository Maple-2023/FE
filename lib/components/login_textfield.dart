import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final loginController;
  final String hintText;
  final bool obscureText;

  const LoginTextField({
    super.key,
    required this.loginController,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          controller: loginController,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 150, 232, 148)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 150, 232, 148)),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
          ),
        ));
  }
}
