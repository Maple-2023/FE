import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import '../../colors.dart';

final List<LatLng> pathCoordinates = [];

Widget recommandResultBox(
    double deviceWidth, int minute, double distance, var routes) {
  minute = minute;
  for (var coord in routes) {
    pathCoordinates.add(LatLng(coord[0], coord[1]));
  }

  return SizedBox(
    height: 150,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _buildMap(),
          Positioned(child: _buildInformRow(minute, distance)),
        ],
      ),
    ),
  );
}

Widget _buildMap() {
  return FlutterMap(
    options: MapOptions(
      interactiveFlags: InteractiveFlag.none,
      bounds: LatLngBounds.fromPoints(pathCoordinates),
      boundsOptions: const FitBoundsOptions(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
      ),
    ),
    children: [
      Opacity(
        opacity: 0.6,
        child: TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          subdomains: const ['a', 'b', 'c'],
        ),
      ),
      PolylineLayer(
        polylines: [
          Polyline(
            points: pathCoordinates,
            color: mainOrange,
            strokeWidth: 4,
          )
        ],
      )
    ],
  );
}

Widget _buildInformRow(int minute, double distance) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "• $minute 분",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "• $distance Km",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: mainGreen2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          child: const Text(
            "G O",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        )
      ],
    ),
  );
}
