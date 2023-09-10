import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker marker(String id, Position position, BitmapDescriptor icon) {
  return Marker(
    markerId: MarkerId("startLoation"),
    position: LatLng(position.latitude, position.longitude),
    icon: icon,
  );
}
