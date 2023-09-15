import 'package:geolocator/geolocator.dart';

Future<Position> getPosition() async {
  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium);
  return position;
}
