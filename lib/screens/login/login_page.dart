import 'package:flutter/material.dart';
import 'package:flutter_mamap/screens/login/login_button.dart';
import 'package:flutter_mamap/screens/login/login_square_tile.dart';
import 'package:flutter_mamap/services/auth_service.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 180),

              //logo
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // 로고 이미지 넣을 것
                    // Image.asset(
                    //   'lib/images/green_leaf.png',
                    //   height: 100,
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 250),

              LoginButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 25),

              // 간편 로그인
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '간편 로그인',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginSquareTile(
                    onTap: () async {
                      AuthService().signInWithGoogle();
                      // 완료시
                    },
                    imagePath: "assets/images/google_logo.png",
                  ),
                ],
              )
            ],
          )),
        ));
  }
}
