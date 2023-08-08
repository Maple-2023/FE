import 'package:flutter/material.dart';
import 'package:flutter_mamap/screens/home/home.dart';
import 'package:flutter_mamap/screens/recommand/recommand.dart';
import 'package:flutter_mamap/screens/recommand/recommand_result.dart';
import 'package:flutter_mamap/screens/walking/walking.dart';

void main() {
  runApp(const MyApp());
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
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Home(),
        "/recommand": (context) => const Recommand(),
        "/recommand_result": (context) => const RecommandResult(),
        "/walking": (context) => const Walking(),
      },
    );
  }
}
