import 'package:flutter/material.dart';

Widget recordingBox(
    double width, double height, int steps, double distance, int energy) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(
        width: width,
        height: height,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("$steps",
              style:
                  const TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
          const Text("걸음", style: TextStyle(fontSize: 17))
        ]),
      ),
      SizedBox(
        width: width,
        height: height,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("$distance",
              style:
                  const TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
          const Text("Km", style: TextStyle(fontSize: 17))
        ]),
      ),
      SizedBox(
        width: width,
        height: height,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("$energy",
              style:
                  const TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
          const Text("Kcal", style: TextStyle(fontSize: 17))
        ]),
      ),
    ],
  );
}
