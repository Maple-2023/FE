import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_mamap/colors.dart';
import 'package:flutter_mamap/services/apiService.dart';
import 'package:flutter_mamap/utilities/informController.dart';
import 'package:flutter_mamap/utilities/weatherCondition.dart';
import 'package:flutter_mamap/widgets/weather_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../utilities/getPosition.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String nick;

  int? temp;
  String? weatherTxt;
  String? location;

  Map<DateTime, int> record = {
    DateTime(2023, 9, 1): 1,
    DateTime(2023, 9, 2): 2,
    DateTime(2023, 9, 4): 1,
    DateTime(2023, 9, 5): 1,
    DateTime(2023, 9, 6): 2,
  };

  @override
  void initState() {
    Future<Position> currentPosition = getPosition();

    nick = "루루루피";

    currentPosition.then((position) async {
      double tmpLatitude = position.latitude;
      double tmpLongitude = position.longitude;
      Get.find<InformController>().setNowLatitude(tmpLatitude);
      Get.find<InformController>().setNowLongitude(tmpLongitude);

      // 위도 경도 기반 날씨 설정
      final weather = await ApiService().getWeather(tmpLatitude, tmpLongitude);
      weatherTxt = weatherCondition(weather["conditionId"]);
      temp = weather["temp"];

      // 위도 경도 기반 위치 설정
      final locationTxt =
          await ApiService().getLocation(tmpLatitude, tmpLongitude);
      location = locationTxt["location"];
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constrains) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _buildInformPanel(deviceWidth, deviceHeight),
            _buildCalendarPanel(deviceWidth, deviceHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildInformPanel(double deviceWidth, double deviceHeight) {
    return Container(
      width: deviceWidth,
      height: deviceHeight * 0.41,
      color: mainGreen1,
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: deviceHeight * 0.05),
          _buildUserInfrom(deviceWidth, deviceHeight),
          _buildInformBox(deviceWidth, deviceHeight, 25, 15),
          _buildStartButt(deviceWidth, deviceHeight),
        ],
      ),
    );
  }

  Widget _buildCalendarPanel(double deviceWidth, double deviceHeight) {
    return Container(
      width: deviceWidth,
      height: deviceHeight * 0.47,
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      color: Colors.white,
      child: HeatMapCalendar(
        datasets: record,
        size: 35,
        borderRadius: 25,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 5),
        showColorTip: false,
        monthFontSize: 18,
        weekFontSize: 15,
        weekTextColor: black,
        textColor: gray,
        colorMode: ColorMode.color,
        colorsets: const {
          1: mainGreen1,
          2: mainOrange,
        },
      ),
    );
  }

  Widget _buildUserInfrom(double deviceWidth, double deviceHeight) {
    return SizedBox(
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
              Text("현위치 $location", style: const TextStyle(fontSize: 13.5)),
              const SizedBox(height: 10),
              weatherWidget(temp, weatherTxt),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInformBox(
      double deviceWidth, double deviceHeight, double numSize, double txtSize) {
    double width = deviceWidth * 0.25;
    double height = deviceHeight * 0.08;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return Text(Get.find<InformController>().daySteps.toString(),
                      style: TextStyle(
                          fontSize: numSize, fontWeight: FontWeight.w500));
                }),
                Text("걸음", style: TextStyle(fontSize: txtSize))
              ]),
        ),
        SizedBox(
          width: width,
          height: height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return Text(
                      Get.find<InformController>().dayDistance.toString(),
                      style: TextStyle(
                          fontSize: numSize, fontWeight: FontWeight.w500));
                }),
                Text("Km", style: TextStyle(fontSize: txtSize))
              ]),
        ),
        SizedBox(
          width: width,
          height: height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return Text(Get.find<InformController>().dayEnergy.toString(),
                      style: TextStyle(
                          fontSize: numSize, fontWeight: FontWeight.w500));
                }),
                Text("Kcal", style: TextStyle(fontSize: txtSize))
              ]),
        ),
      ],
    );
  }

  Widget _buildStartButt(double deviceWidth, double deviceHeight) {
    return SizedBox(
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
              color: black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
