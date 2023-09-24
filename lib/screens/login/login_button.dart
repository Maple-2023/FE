import 'package:flutter/material.dart';

import '../../colors.dart';

class loginButton extends StatelessWidget {
  final String buttonImgPath;
  final String buttonText;
  final Color buttonColor;
  final double width;
  final Function()? onPressButton;

  const loginButton({
    super.key,
    required this.buttonImgPath,
    required this.buttonText,
    required this.buttonColor,
    required this.width,
    required this.onPressButton,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressButton,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        fixedSize: Size(width, 60),
        elevation: 2,
        shadowColor: whiteGray,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonText == "Naver"
              ? Image.asset(
                  buttonImgPath,
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  buttonImgPath,
                  width: 35,
                  height: 35,
                  fit: BoxFit.fill,
                ),
          Text(
            "$buttonText로 시작하기",
            style: TextStyle(fontSize: 20, color: black),
          ),
        ],
      ),
    );
  }
}
