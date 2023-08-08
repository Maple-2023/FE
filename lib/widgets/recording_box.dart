import 'package:flutter/material.dart';

Widget recordingBox(double width, double height, int steps, double distance,
    int energy, double numSize, double txtSize) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(
        width: width,
        height: height,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("$steps",
              style: TextStyle(fontSize: numSize, fontWeight: FontWeight.w500)),
          Text("걸음", style: TextStyle(fontSize: txtSize))
        ]),
      ),
      SizedBox(
        width: width,
        height: height,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("$distance",
              style: TextStyle(fontSize: numSize, fontWeight: FontWeight.w500)),
          Text("Km", style: TextStyle(fontSize: txtSize))
        ]),
      ),
      SizedBox(
        width: width,
        height: height,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("$energy",
              style: TextStyle(fontSize: numSize, fontWeight: FontWeight.w500)),
          Text("Kcal", style: TextStyle(fontSize: txtSize))
        ]),
      ),
    ],
  );
}
