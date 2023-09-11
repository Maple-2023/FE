import 'package:flutter_mamap/domain/user_domain.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

Future<void> saveUser(User user) async {
  try {
    final response = await http.post(
      Uri.parse("http://server-uri/user"), // 내 db 서버 uri 넣기
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to send data");
    } else {
      print("User Data sent successfully");
      Get.to(const HomePage()); //page 클래스 이름 적기
    }
  } catch (e) {
    print("Failed to send post data: ${e}");
  }
}
