import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_mamap/colors.dart';
import 'package:flutter_mamap/screens/walking/recording_box.dart';

class Walking extends StatelessWidget {
  const Walking({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    bool isFinished = false;
    bool isStopped = false;
    int steps = 5564;
    double distance = 5.5;
    double progressing = 30;
    int energy = 221;

    return LayoutBuilder(
      builder: (context, constrains) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceHeight * 0.68,
              width: deviceWidth,
            ),
            Container(
                color: const Color.fromARGB(69, 230, 229, 229),
                height: deviceHeight * 0.32,
                width: deviceWidth,
                padding: const EdgeInsets.only(bottom: 30, top: 30),
                child: isFinished == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: deviceWidth,
                            height: deviceHeight * 0.05,
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.05,
                                right: deviceWidth * 0.05,
                                bottom: 5),
                            child: FAProgressBar(
                              currentValue: progressing,
                              progressColor: mainGreen1,
                              backgroundColor: Colors.white,
                              size: 35,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          recordingBox(deviceWidth * 0.25, deviceHeight * 0.08,
                              steps, distance, energy),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isStopped == false
                                  ? IconButton(
                                      iconSize: 60,
                                      color: mainGreen1,
                                      onPressed: () {
                                        isStopped = true;
                                      },
                                      icon: Icon(
                                        isStopped == false
                                            ? Icons.pause_circle
                                            : Icons.play_circle,
                                      ),
                                    )
                                  : IconButton(
                                      iconSize: 60,
                                      color: mainGreen1,
                                      onPressed: () {
                                        isStopped = false;
                                      },
                                      icon: const Icon(
                                        Icons.play_circle,
                                      ),
                                    ),
                              const SizedBox(width: 30),
                              IconButton(
                                iconSize: 60,
                                color: mainGreen1,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.stop_circle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: deviceWidth * 0.9,
                            height: deviceHeight * 0.12,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: recordingBox(deviceWidth * 0.25,
                                deviceHeight * 0.08, steps, distance, energy),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: deviceWidth * 0.35,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainOrange,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                  child: const Text("경로 저장",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                              SizedBox(width: deviceWidth * 0.18),
                              SizedBox(
                                width: deviceWidth * 0.35,
                                height: 45,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainGreen1,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                    child: const Text("산책 종료",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500))),
                              )
                            ],
                          ),
                        ],
                      )),
          ],
        ),
      ),
    );
  }
}
