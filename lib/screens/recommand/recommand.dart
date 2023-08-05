import 'package:flutter/material.dart';
import 'package:flutter_mamap/colors.dart';
import 'package:flutter_mamap/screens/recommand/recommand_button.dart';

class Recommand extends StatelessWidget {
  const Recommand({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constrains) => Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                width: deviceWidth,
                height: deviceHeight * 0.2,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 55, bottom: 20, left: 20, right: 20),
                  decoration: const BoxDecoration(
                      color: mainGreen1,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "산책 계획",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("현위치와 가까워요"),
                            Text("서울 구로구 오류2동"),
                            // 아이콘 버튼 추가할 것
                          ],
                        )
                      ]),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      recommandButton(1, context),
                      const SizedBox(width: 15),
                      recommandButton(2, context)
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      recommandButton(3, context),
                      const SizedBox(width: 15),
                      recommandButton(4, context)
                    ],
                  ),
                  const SizedBox(height: 15),
                  recommandButton(5, context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
