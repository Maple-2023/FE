import 'package:flutter/material.dart';
import 'package:flutter_mamap/screens/recommand/recommand_result_box.dart';

import '../../colors.dart';

class RecommandResult extends StatelessWidget {
  const RecommandResult({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final argument = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;
    final location = argument["location"];
    return LayoutBuilder(
      builder: (context, constrains) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: black),
          backgroundColor: mainGreen1,
          toolbarHeight: deviceHeight * 0.1,
          elevation: 0,
          title: const Text(
            "산책 계획",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: black),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              width: deviceWidth,
              height: deviceHeight * 0.05,
              child: Container(
                padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
                decoration: const BoxDecoration(
                    color: mainGreen1,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("현위치와 가까워요",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Text("$location",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                    // 아이콘 버튼 추가할 것
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            recommandResultBox(deviceWidth),
            const SizedBox(height: 30),
            recommandResultBox(deviceWidth),
            const SizedBox(height: 30),
            recommandResultBox(deviceWidth),
          ],
        ),
      ),
    );
  }
}
