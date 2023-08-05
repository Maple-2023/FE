import 'package:flutter/material.dart';

import '../../colors.dart';

Widget recommandButton(int num, BuildContext context) {
  String minutes;
  double width = 150;
  switch (num) {
    case 1:
      minutes = "15분";
      break;
    case 2:
      minutes = "30분";
      break;
    case 3:
      minutes = "45분";
      break;
    case 4:
      minutes = "60분";
      break;
    default:
      minutes = "내가 저장한 코스";
      width = 330;
      break;
  }

  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, "/recommand_result");
    },
    style: ButtonStyle(
      overlayColor: MaterialStateColor.resolveWith(
          (states) => const Color.fromARGB(6, 0, 0, 0)),
    ),
    child: Container(
      height: 150,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: num != 5
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/sand_clock$num.png",
                  width: 70,
                  height: 70,
                ),
                const SizedBox(height: 15),
                Text(
                  minutes,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400, color: black),
                ),
              ],
            )
          : Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                        color: mainGreen1,
                        gradient: RadialGradient(
                          radius: 0.8,
                          colors: [
                            Color(0xff96E894),
                            Color.fromARGB(140, 149, 232, 148)
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                  ),
                  Text(
                    minutes,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                ],
              ),
            ),
    ),
  );
}
