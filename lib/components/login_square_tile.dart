import 'package:flutter/material.dart';

class loginSquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const loginSquareTile({
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
