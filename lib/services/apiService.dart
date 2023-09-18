import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mamap/models/recommandCourse.dart';
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
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        String tmpLocation = data["results"][0]["formatted_address"];
        List<String> locations = tmpLocation.split(' ');
        return {
          "flag": true,
          "location": "${locations[1]} ${locations[2]} ${locations[3]}",
        };
      } else {
        return {"flag": false};
      }
    } catch (e) {
      return {"flag": false};
    }
  }

  Future<dynamic> getRecommandCourses(
      double latitude, double longitude, int minute) async {
    //final url = Uri.parse('주소 & 위도, 경도, 소요시간');
    //final response = await http.get(url);

    List<RecommandCourse> recommandcourses = [];
    for (var course in testData) {
      recommandcourses.add(RecommandCourse.fromJson(course));
    }
    return recommandcourses;
    // if (response.statusCode == 200) {
    //     var data = jsonDecode(utf8.decode(response.bodyBytes));
    //     List<roccoma> mailCategories = [];
    //     for (var mailData in data) {
    //       mailCategories.add(MailCategory.fromJson(mailData));
    //     }
    //     return mailCategories;
    //   } else {
    //     logger.d('오류 ${response.statusCode}');
    //     return [];
    //   }
    // } catch (e) {
    //   logger.d(e.toString());
    //   return [];
    // }
  }
}

List<Map<String, dynamic>> testData = [
  {
    "minute": 26,
    "distance": 2.5,
    "routes": [
      [37.46191106805, 126.8235334232],
      [37.46391106805, 126.8235334234],
      [37.46391106807, 126.8215334234],
      [37.46591106805, 126.818],
      [37.462454323, 126.8177778],
      [37.46187444, 126.816],
      [37.463361722, 126.8140076],
    ]
  },
  {
    "minute": 29,
    "distance": 2.6,
    "routes": [
      [37.48191106805, 126.8235334232],
      [37.482, 126.83],
      [37.482, 126.8435334279],
      [37.4869110720, 126.843533425],
      [37.49, 126.823533435],
      [37.494733, 126.855555],
    ]
  },
  {
    "minute": 31,
    "distance": 2.8,
    "routes": [
      [37.4762158949391, 126.817405463034],
      [37.48, 126.820],
      [37.48191106805, 126.8235334232],
      [37.48191106805, 126.823533425],
      [37.487346933855, 126.82958562765],
      [37.488303982902, 126.83070887463],
      [37.489729501764, 126.83355781841],
    ]
  },
];
