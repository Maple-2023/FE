import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../../colors.dart';

Widget progressBar(
    double deviceWidth, double deviceHeight, double progressing) {
  return Container(
    width: deviceWidth,
    height: deviceHeight * 0.05,
    padding: EdgeInsets.only(
      left: deviceWidth * 0.05,
      right: deviceWidth * 0.05,
      bottom: 5,
    ),
    child: FAProgressBar(
      currentValue: progressing,
      progressColor: mainGreen1,
      backgroundColor: Colors.white,
      size: 35,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
  );
}
