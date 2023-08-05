import 'package:flutter/material.dart';
import 'colors.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma Map',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white
          //fontFamily: 글씨체 정하기
          ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => const Login(),
      },
    );
  }
}
