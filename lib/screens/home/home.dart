import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_mamap/colors.dart';
import 'package:flutter_mamap/widgets/recording_box.dart';
import 'package:flutter_mamap/widgets/weather_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    int steps = 6645;
    int energy = 211;
    double distance = 3.2;
    String nick = "루루루피";
    String location = "서울시 구로구 오류2동";
    int temp = 27;
    String weather = "조금 맑음";
    Map<DateTime, int> record = {
      DateTime(2023, 8, 1): 1,
      DateTime(2023, 8, 2): 2,
      DateTime(2023, 8, 4): 1,
      DateTime(2023, 8, 5): 1,
      DateTime(2023, 8, 6): 2,
    };

    return LayoutBuilder(
      builder: (context, constrains) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: deviceWidth,
              height: deviceHeight * 0.45,
              color: mainGreen1,
              padding: const EdgeInsets.only(
                  top: 30, left: 20, right: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: deviceHeight * 0.05),
                  SizedBox(
                    height: deviceHeight * 0.13,
                    width: deviceWidth * 0.83,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/profile.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "$nick님 안녕하세요!",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2),
                            ),
                            const SizedBox(height: 2),
                            Text("현위치 $location",
                                style: const TextStyle(fontSize: 13.5)),
                            const SizedBox(height: 10),
                            weatherWidget(temp, weather),
                          ],
                        ),
                      ],
                    ),
                  ),
                  recordingBox(deviceWidth * 0.25, deviceHeight * 0.07, steps,
                      distance, energy, 23, 15),
                  SizedBox(
                    width: deviceWidth * 0.8,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/walking");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text(
                          "S T A R T",
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )),
                  )
                ],
              ),
            ),
            Container(
              width: deviceWidth,
              height: deviceHeight * 0.55,
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              color: Colors.white,
              child: HeatMapCalendar(
                datasets: record,
                size: 40,
                borderRadius: 25,
                margin: const EdgeInsets.all(5),
                showColorTip: false,
                monthFontSize: 20,
                weekFontSize: 15,
                weekTextColor: black,
                textColor: gray,
                colorMode: ColorMode.color,
                colorsets: const {
                  1: mainGreen1,
                  2: mainOrange,
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
