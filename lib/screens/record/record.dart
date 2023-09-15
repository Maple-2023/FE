import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

bool isMonthly = true;

class _RecordState extends State<Record> {
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
            "산책 기록",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: black),
          ),
        ),
        body: Column(children: [
          _buildControlPannel(deviceWidth, deviceHeight),
          _buildCalendarPannel(deviceWidth, deviceHeight),
        ]),
      ),
    );
  }

  Widget _buildControlPannel(double deviceWidth, double deviceHeight) {
    return Container(
        width: deviceWidth,
        height: deviceHeight * 0.12,
        alignment: Alignment.center,
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
        child: SlidingSwitch(
          value: false,
          width: deviceWidth * 0.75,
          height: deviceHeight * 0.07,
          onChanged: (bool value) {
            isMonthly = !isMonthly;
            setState(() {});
          },
          animationDuration: const Duration(milliseconds: 400),
          onTap: () {},
          onDoubleTap: () {},
          onSwipe: () {},
          textOff: "MONTHLY",
          textOn: "WEEKLY",
          contentSize: 17,
          colorOn: gray,
          colorOff: gray,
          background: whiteGray,
          buttonColor: Colors.white,
          inactiveColor: gray,
        ));
  }

  Widget _buildCalendarPannel(double deviceWidth, double deviceHeight) {
    return Container(
        width: deviceWidth,
        height: deviceHeight * 0.6,
        alignment: Alignment.center,
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        child: isMonthly ? _buildMonthly() : const Text("dnld"));
  }

  Widget _buildMonthly() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
    );
  }
}
