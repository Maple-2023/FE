import 'package:flutter/material.dart';

Widget weatherWidget(int temp, String txt) {
  IconData icon = Icons.question_mark;
  switch (txt) {
    case "맑음":
      icon = Icons.sunny;
      break;
    case "구름":
      icon = Icons.cloud;
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
          "$temp °C",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          txt,
          style: const TextStyle(
            fontSize: 13,
          ),
        )
      ])
    ],
  );
}
