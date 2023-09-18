import 'package:flutter/material.dart';
import 'package:flutter_mamap/components/login_textfield.dart';
import 'package:flutter_mamap/components/login_button.dart';
import 'package:flutter_mamap/components/login_square_tile.dart';
import 'package:flutter_mamap/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                    Image.asset(
                      'lib/images/green_leaf.png',
                      height: 100,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              LoginTextField(
                loginController: emailController,
                hintText: '이메일을 입력하세요',
                obscureText: false,
              ),

              const SizedBox(height: 15),

              LoginTextField(
                loginController: passwordController,
                hintText: '비밀번호를 입력하세요',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Text(
                      '비밀번호 찾기',
                      style: TextStyle(color: Colors.grey[600]),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),

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
                  loginSquareTile(
                    onTap: () => AuthService().signInWithGoogle(),
                    imagePath: 'lib/images/google_logo.png',
                  ),
                ],
              )
            ],
          )),
        ));
  }
}
