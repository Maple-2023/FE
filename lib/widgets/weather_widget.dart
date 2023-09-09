import 'package:flutter/material.dart';

Widget weatherWidget(int? temp, String? txt) {
  IconData icon = Icons.question_mark;
  switch (txt) {
    case "맑음":
      icon = Icons.sunny;
      break;
    case "흐림":
      icon = Icons.cloud;
      break;
    case "비" "약한 비":
      icon = Icons.umbrella_outlined;
      break;
    case "눈":
      icon = Icons.cloudy_snowing;
      break;
    case "뇌우 및 비":
      icon = Icons.thunderstorm;
      break;
    default:
      icon = Icons.question_mark;
      break;
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Icon(
        icon,
        color: Colors.white,
        size: 35,
      ),
      const SizedBox(width: 20),
      Column(children: [
        Text(
          "${temp ?? 0} °C",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          txt ?? "알 수 없음",
          style: const TextStyle(
            fontSize: 13,
          ),
        )
      ])
    ],
  );
}
