import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

class ApiService {
  final String _weatherApiKey = dotenv.env['OPEN_WEATHER_API_KEY'] ?? '';
  final String _geocodingApiKey = dotenv.env['GEOCODING_API_KEY'] ?? '';

  Future<dynamic> getWeather(double latitude, longitude) async {
    try {
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$_weatherApiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        double temp = (data['main']['temp'] - 273.15);

        return {
          "flag": true,
          "temp": temp.round(),
          "conditionId": data["weather"][0]["id"],
          "condition": data['weather'][0]['main'],
          "humidity": data['main']['humidity']
        };
      } else {
        return {"flag": false};
      }
    } catch (e) {
      return {"flag": false};
    }
  }

  Future<dynamic> getLocation(double latitude, longitude) async {
    try {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&language=ko&key=$_geocodingApiKey');
      final response = await http.get(url);
      logger.d(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        logger.d(data);

        return {
          "flag": true,
        };
      } else {
        return {"flag": false};
      }
    } catch (e) {
      return {"flag": false};
    }
  }
}
