import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mamap/colors.dart';
import 'package:flutter_mamap/screens/walking/iconMarker.dart';
import 'package:flutter_mamap/screens/walking/makingPolyline.dart';
import 'package:flutter_mamap/utilities/informController.dart';
import 'package:flutter_mamap/widgets/recording_box.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/quickalert.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../utilities/getPosition.dart';

var logger = Logger();

class RecommandWalking extends StatefulWidget {
  const RecommandWalking({super.key});

  @override
  State<RecommandWalking> createState() => _RecommandWalkingState();
}

class _RecommandWalkingState extends State<RecommandWalking> {
  late double distance, progressing;
  late int steps, energy, time;
  bool isFinished = false;
  bool isStopped = false;
  late String displayTime;
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  BitmapDescriptor startPositionIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentPositionIcon = BitmapDescriptor.defaultMarker;

  // 지도관련 경로, 위치
  final Set<Polyline> polyline = {};
  List<LatLng> route = [];
  Position? startPosition, currentPosition;
  GoogleMapController? googleMapController;
  late StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    steps = energy = time = 0;
    distance = progressing = 0;
    route.clear();
    polyline.clear();

    getCurrentPosition();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentPosition();
    });
    setCustomMarker();

    resetTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constrains) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildGoogleMap(deviceWidth, deviceHeight),
            _buildPannel(deviceWidth, deviceHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleMap(double deviceWidth, double deviceHeight) {
    return SizedBox(
      height: deviceHeight * 0.68,
      width: deviceWidth,
      child: currentPosition == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              polylines: polyline,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: {
                iconMarker("start", startPosition!, startPositionIcon),
                iconMarker("current", currentPosition!, currentPositionIcon),
              },
              initialCameraPosition: CameraPosition(
                zoom: 15,
                target: LatLng(
                  currentPosition!.latitude,
                  currentPosition!.longitude,
                ),
              ),
              onMapCreated: _onMapCreated,
            ),
    );
  }

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/startPin.png")
        .then(
      (icon) {
        startPositionIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/currentPin.png")
        .then(
      (icon) {
        currentPositionIcon = icon;
      },
    );
  }

  void resetTimer() {
    stopWatchTimer.onResetTimer();
    stopWatchTimer.clearPresetTime();
    stopWatchTimer.onStartTimer();
  }

  Future<void> getCurrentPosition() async {
    currentPosition = await getPosition();
    startPosition ??= currentPosition;
    setState(() {});

    if (currentPosition != null) {
      LocationSettings locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.medium, distanceFilter: 3);

      // start를 빠르게 누르면 마크가 갑자기 옮겨지는 일이 발생함
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen(
        (Position? position) async {
          currentPosition = position;

          if (route.isNotEmpty) {
            distance = double.parse((distance +
                    (Geolocator.distanceBetween(
                          route.last.latitude,
                          route.last.longitude,
                          position!.latitude,
                          position.longitude,
                        ) /
                        1000))
                .toStringAsFixed(2));
            if (route.last != LatLng(position.latitude, position.longitude)) {
              route.add(LatLng(position.latitude, position.longitude));
              polyline.add(makingPolyline(position, route));
            }
          } else {
            route.add(LatLng(position!.latitude, position.longitude));
          }
          setState(() {});

          googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 15,
                target: LatLng(
                    currentPosition!.latitude, currentPosition!.longitude),
              ),
            ),
          );
        },
      );
      setState(() {});
    }
  }

  Widget _buildPannel(double deviceWidth, double deviceHeight) {
    return Container(
      color: const Color.fromARGB(69, 230, 229, 229),
      height: deviceHeight * 0.32,
      width: deviceWidth,
      padding: const EdgeInsets.only(bottom: 30, top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StreamBuilder<int>(
            stream: stopWatchTimer.rawTime,
            initialData: 0,
            builder: (context, snap) {
              int tmpTime = snap.data!;
              displayTime =
                  "${StopWatchTimer.getDisplayTimeHours(tmpTime)}:${StopWatchTimer.getDisplayTimeMinute(tmpTime)}:${StopWatchTimer.getDisplayTimeSecond(tmpTime)}";

              time = ((time + tmpTime) / 1000).round();
              energy = (time / 15).round(); // 평균적으로 1분에 4칼로리 -> 60/4 = 1칼로리

              return Container(
                width: deviceWidth * 0.9,
                height: deviceHeight * 0.12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: recordingBox(
                  deviceWidth * 0.25,
                  deviceHeight * 0.08,
                  steps,
                  distance,
                  energy,
                  27,
                  17,
                ),
              );
            },
          ),
          isFinished == false
              ? _buildRunningButtons(deviceWidth, deviceHeight)
              : _buildFinishedButtons(deviceWidth, deviceHeight),
        ],
      ),
    );
  }

  Widget _buildRunningButtons(double deviceWidth, double deviceHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 60,
          color: mainGreen1,
          icon: Icon(isStopped ? Icons.play_circle : Icons.pause_circle),
          onPressed: _onPressStopRecording,
        ),
        const SizedBox(width: 30),
        IconButton(
          iconSize: 60,
          color: mainGreen1,
          onPressed: _onPressFinishRecording,
          icon: const Icon(
            Icons.stop_circle,
          ),
        ),
      ],
    );
  }

  Widget _buildFinishedButtons(double deviceWidth, double deviceHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: deviceWidth * 0.4,
          height: 45,
          child: _buildAfterFinishButton("경로 저장", mainGreen1),
        ),
        SizedBox(width: deviceWidth * 0.09),
        SizedBox(
          width: deviceWidth * 0.4,
          height: 45,
          child: _buildAfterFinishButton("산책 종료", mainOrange),
        ),
      ],
    );
  }

  Widget _buildAfterFinishButton(String txt, Color color) {
    return ElevatedButton(
      onPressed: () {
        if (txt == "경로 저장") {
          _onPressAfterFinish(true);
        } else {
          _onPressAfterFinish(false);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: Text(
        txt,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _onMapCreated(GoogleMapController mapController) {
    setState(() {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 15,
            target: LatLng(
              currentPosition!.latitude,
              currentPosition!.longitude,
            ),
          ),
        ),
      );
      googleMapController = mapController;
    });
  }

  void _onPressStopRecording() {
    if (!isStopped) {
      // 정지버튼
      stopWatchTimer.onStopTimer();
      positionStream?.pause();
    } else {
      // 재생버튼
      stopWatchTimer.onStartTimer();
      positionStream?.resume();
    }
    setState(() {
      isStopped = !isStopped;
    });
  }

  void _onPressFinishRecording() async {
    stopWatchTimer.onStopTimer();
    await positionStream?.cancel();
    positionStream = null;

    setState(() {
      isFinished = !isFinished;
      isStopped = true;
    });
  }

  void _onPressAfterFinish(bool record) async {
    Get.find<InformController>()
        .setDaySteps(Get.find<InformController>().daySteps.value + steps);
    Get.find<InformController>().setDayDistance(
        Get.find<InformController>().dayDistance.value + distance);
    Get.find<InformController>()
        .setDayEnergy(Get.find<InformController>().dayEnergy.value + energy);
    Get.find<InformController>()
        .setDayTime(Get.find<InformController>().dayTime.value + time);

    Get.find<InformController>().nowLatitude(currentPosition!.latitude);
    Get.find<InformController>().nowLongiude(currentPosition!.longitude);

    if (record) {
      // 경로들 DB에 저장하고 알림주기

      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: "기록이 정상적으로 저장되었습니다.",
      );
    }
    if (!mounted) return;
    Navigator.pop(context);
  }
}
