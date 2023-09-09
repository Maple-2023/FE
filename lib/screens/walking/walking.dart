import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_mamap/colors.dart';
import 'package:flutter_mamap/widgets/recording_box.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../utilities/getPosition.dart';

var logger = Logger();

class Walking extends StatefulWidget {
  const Walking({super.key});

  @override
  State<Walking> createState() => _WalkingState();
}

class _WalkingState extends State<Walking> {
  late double distance, progressing;
  late int steps, energy;

  // 경로 그리기 위해 필요함
  final Set<Polyline> polyline = {};
  List<LatLng> route = [];

  // 초기 값
  double dist = 0;
  late String displayTime;
  late int time, lastestTime;
  final StopWatchTimer stopWatchTimer = StopWatchTimer();

  // 초기 위치 및 거리
  LatLng sourceLocation = const LatLng(38.432199, 27.177221);
  Position? startPosition, currentPosition;
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  late StreamSubscription<Position> positionStream;

  BitmapDescriptor startPositionIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentPositionIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    steps = energy = 0;
    distance = progressing = 0;
    getCurrentPosition();
    setCustomMarkerIcon();
    route.clear();
    polyline.clear();
    dist = 0;
    time = lastestTime = 0;

    stopWatchTimer.onResetTimer();
    stopWatchTimer.clearPresetTime();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentPosition();
    });
    stopWatchTimer.onStartTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    stopWatchTimer.dispose();
  }

  void setCustomMarkerIcon() {
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

  Future<void> getCurrentPosition() async {
    startPosition = currentPosition = await getPosition();
    logger.d("first position $currentPosition");
    setState(() {});

    if (currentPosition != null) {
      LocationSettings locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.medium, distanceFilter: 3);
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen(
        (Position? position) async {
          logger.d(position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');

          currentPosition = position;

          if (route.isNotEmpty) {
            dist = dist +
                Geolocator.distanceBetween(
                    route.last.latitude,
                    route.last.longitude,
                    position!.latitude,
                    position.longitude);
          }
          lastestTime = time;

          if (route.isNotEmpty) {
            if (route.last != LatLng(position!.latitude, position.longitude)) {
              route.add(LatLng(position.latitude, position.longitude));

              polyline.add(Polyline(
                  polylineId: PolylineId(position.toString()),
                  // 기본값이랑 똑같음visible: true,
                  points: route,
                  width: 6,
                  startCap: Cap.roundCap,
                  endCap: Cap.roundCap,
                  color: mainGreen1));
            }
          } else {
            route.add(LatLng(position!.latitude, position.longitude));
          }
          setState(() {});

          GoogleMapController googleMapController = await controller.future;
          googleMapController.animateCamera(
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

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    bool isFinished = false;
    bool isStopped = false;

    return LayoutBuilder(
      builder: (context, constrains) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceHeight * 0.68,
              width: deviceWidth,
              child: currentPosition == null
                  ? const Center(child: Text("Loading"))
                  : GoogleMap(
                      polylines: polyline,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      markers: {
                        Marker(
                          markerId: MarkerId("startLoation"),
                          position: LatLng(startPosition!.latitude,
                              startPosition!.longitude),
                          icon: startPositionIcon,
                        ),
                        Marker(
                            markerId: MarkerId("currentPosition"),
                            position: LatLng(currentPosition!.latitude,
                                currentPosition!.longitude),
                            icon: currentPositionIcon),
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentPosition!.latitude,
                              currentPosition!.longitude),
                          zoom: 15),
                      onMapCreated: (mapController) {
                        mapController
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                            zoom: 15,
                            target: LatLng(currentPosition!.latitude,
                                currentPosition!.longitude),
                          ),
                        ));
                        setState(() {});
                      },
                    ),
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
                          StreamBuilder<int>(
                            stream: stopWatchTimer.rawTime,
                            initialData: 0,
                            builder: (context, snap) {
                              time = snap.data!;
                              displayTime =
                                  "${StopWatchTimer.getDisplayTimeHours(time)}:${StopWatchTimer.getDisplayTimeMinute(time)}:${StopWatchTimer.getDisplayTimeSecond(time)}";
                              return Text(displayTime);
                            },
                          ),
                          recordingBox(deviceWidth * 0.25, deviceHeight * 0.08,
                              steps, distance, energy, 27, 17),
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
                            child: recordingBox(
                                deviceWidth * 0.25,
                                deviceHeight * 0.08,
                                steps,
                                distance,
                                energy,
                                27,
                                17),
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
