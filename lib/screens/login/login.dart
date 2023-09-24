import 'package:flutter/material.dart';
import 'package:flutter_mamap/screens/login/login_button.dart';
import 'package:flutter_mamap/screens/login/login_platform.dart';
import 'package:flutter_mamap/services/auth_service.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              SizedBox(height: deviceHeight * 0.1),
              _buildLogoPannel(deviceHeight),
              SizedBox(height: deviceHeight * 0.13),
              _buildLoginButtonPannel(context, deviceWidth),
            ],
          )),
        ));
  }

  Widget _buildLogoPannel(double deviceHeight) {
    return Column(
      children: [
        Text(
          "Ma map",
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: deviceHeight * 0.05),
        Image.asset("assets/images/logo.png",
            fit: BoxFit.fill,
            height: deviceHeight * 0.2,
            width: deviceHeight * 0.2),
      ],
    );
  }

  Widget _buildLoginButtonPannel(BuildContext context, double deviceWidth) {
    return Column(
      children: [
        loginButton(
          buttonImgPath: "assets/images/google_logo.png",
          buttonText: "Google",
          buttonColor: Color.fromARGB(255, 241, 241, 241),
          width: deviceWidth * 0.85,
          onPressButton: onPressButton(context),
        ),
        SizedBox(height: 20),
        loginButton(
            buttonImgPath: "assets/images/kakao_logo.png",
            buttonText: "Kakao",
            buttonColor: Color(0xffFEE500),
            width: deviceWidth * 0.85,
            onPressButton: onPressButton(context)),
        SizedBox(height: 20),
        loginButton(
            buttonImgPath: "assets/images/naver_logo.png",
            buttonText: "Naver",
            buttonColor: Color(0xff1EC800),
            width: deviceWidth * 0.85,
            onPressButton: onPressButton(context)),
      ],
    );
  }

  Future<dynamic> Function() onPressButton(BuildContext context) {
    return () async {
      LoginPlatform loginPlatform = await AuthService().signInWithGoogle();
      if (loginPlatform != LoginPlatform.none) {
        // DB 정보 불러서 컨트롤러 셋팅
        Navigator.pushNamed(
          context,
          "/bottom_bar",
        );
      } else {
        logger.d("오류");
      }
    };
  }
}
