import 'package:flutter/material.dart';
import 'package:flutter_mamap/colors.dart';
import 'package:flutter_mamap/screens/recommand/recommand_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../services/apiService.dart';
import '../../utilities/getPosition.dart';
import '../../utilities/informController.dart';

class Recommand extends StatefulWidget {
  const Recommand({super.key});

  @override
  State<Recommand> createState() => _RecommandState();
}

double? tmpLatitude, tmpLongitude;

class _RecommandState extends State<Recommand> {
  String location = "???";

  @override
  void initState() {
    Future<Position> currentPosition = getPosition();

    currentPosition.then((position) async {
      tmpLatitude = position.latitude;
      tmpLongitude = position.longitude;
      Get.find<InformController>().setNowLatitude(tmpLatitude!);
      Get.find<InformController>().setNowLongitude(tmpLongitude!);

      // 위도 경도 기반 위치 설정
      final locationTxt =
          await ApiService().getLocation(tmpLatitude!, tmpLongitude!);
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
        appBar: AppBar(
          backgroundColor: mainGreen1,
          toolbarHeight: deviceHeight * 0.1,
          elevation: 0,
          title: const Text(
            "산책 계획",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: black),
          ),
        ),
        body: _buildRecommandPanel(deviceWidth, deviceHeight, context),
      ),
    );
  }

  Widget _buildRecommandPanel(
      double deviceWidth, double deviceHeight, BuildContext context) {
    return Column(
      children: [
        _buildLocationPanel(deviceWidth, deviceHeight),
        tmpLatitude == null
            ? const Center(child: Text("Loading"))
            : Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      recommandButton(
                          1, context, location, tmpLatitude!, tmpLongitude!),
                      const SizedBox(width: 15),
                      recommandButton(
                          2, context, location, tmpLatitude!, tmpLongitude!)
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      recommandButton(
                          3, context, location, tmpLatitude!, tmpLongitude!),
                      const SizedBox(width: 15),
                      recommandButton(
                          4, context, location, tmpLatitude!, tmpLongitude!)
                    ],
                  ),
                  const SizedBox(height: 15),
                  recommandButton(
                      5, context, location, tmpLatitude!, tmpLongitude!),
                ],
              )
      ],
    );
  }

  Widget _buildLocationPanel(double deviceWidth, double deviceHeight) {
    return SizedBox(
      width: deviceWidth,
      height: deviceHeight * 0.05,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
        decoration: const BoxDecoration(
            color: mainGreen1,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("현위치와 가까워요",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(location,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400)),
                const SizedBox(width: 2),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                      onPressed: () {},
                      color: mainOrange,
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.my_location,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
