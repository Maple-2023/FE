import 'package:get/state_manager.dart';

class InformController extends GetxController {
  final String _id = "";
  final _nick = "".obs;
  final String _pw = "";
  final String _accessToken = "";
  final String _refreshToken = "";

  final _daySteps = 0.obs;
  final _dayEnergy = 0.obs;
  final _dayTime = 0.obs;
  final _dayDistance = 0.0.obs;
  final _nowLatitude = 0.0.obs;
  final _nowLongitude = 0.0.obs;

  get id => _id;
  get nick => _nick;
  get pw => _pw;
  get accessToken => _accessToken;
  get refreshToken => _refreshToken;

  get daySteps => _daySteps;
  get dayEnergy => _dayEnergy;
  get dayTime => _dayTime;
  get dayDistance => _dayDistance;
  get nowLatitude => _nowLatitude;
  get nowLongiude => _nowLongitude;

  void setDaySteps(int steps) {
    _daySteps.value = steps;
    update();
  }

  void setDayEnergy(int energy) {
    _dayEnergy.value = energy;
    update();
  }

  void setDayTime(int time) {
    _dayTime.value = time;
    update();
  }

  void setDayDistance(double distance) {
    _dayDistance.value = distance;
    update();
  }

  void setNowLatitude(double latitude) {
    _nowLatitude.value = latitude;
    update();
  }

  void setNowLongitude(double longitude) {
    _nowLongitude.value = longitude;
    update();
  }
}
