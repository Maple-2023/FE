import 'package:flutter/material.dart';

import '../../colors.dart';

Widget recommandResultBox(double deviceWidth) {
  return Container(
    width: deviceWidth * 0.9,
    height: 150,
    alignment: Alignment.bottomLeft,
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)), color: gray),
    child: Row(
      children: const [Text("21분"), SizedBox(width: 15), Text("1.3km")],
    ),
  );
}
