import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mamap/screens/bottom_bar.dart';
import 'package:flutter_mamap/screens/home/home.dart';
import 'package:flutter_mamap/screens/recommand/recommand.dart';
import 'package:flutter_mamap/screens/recommand/recommand_result.dart';
import 'package:flutter_mamap/screens/record/record.dart';
import 'package:flutter_mamap/screens/walking/recommandWalking.dart';
import 'package:flutter_mamap/screens/walking/walking.dart';
import 'package:flutter_mamap/utilities/informController.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

void main() async {
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InformController());
    return GetMaterialApp(
      title: 'Ma Map',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white
          //fontFamily: 글씨체 정하기
          ),
      initialRoute: "/bottom_bar",
      routes: {
        "/home": (context) => const Home(),
        "/recommand": (context) => const Recommand(),
        "/recommand_result": (context) => const RecommandResult(),
        "/walking": (context) => const Walking(),
        "/record": (context) => const Record(),
        "/recommandWalking": (context) => const RecommandWalking(),
        "/bottom_bar": (context) => const BottomBar()
      },
    );
  }
}
