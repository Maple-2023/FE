import 'package:flutter/material.dart';

class LoginSquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const LoginSquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
