import 'package:flutter_mamap/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Polyline makingPolyline(Position position, List<LatLng> route) {
  return Polyline(
      polylineId: PolylineId(position.toString()),
      points: route,
      width: 6,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      color: mainGreen1);
}
