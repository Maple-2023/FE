import 'package:flutter/services.dart';
import 'package:flutter_mamap/screens/login/login_platform.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class AuthService {
  Future<LoginPlatform> signInWithGoogle() async {
    late GoogleSignInAccount? googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // googleUser.displayName = 윤다빈, email = 내메일, googleUser.id = 110593680845624771214(이런식, 고정임)
        // DB에 있다면, 로그인 아니라면 회원가입
        return LoginPlatform.google;
      } else {
        return LoginPlatform.none;
      }
    } on PlatformException catch (error) {
      if (error.code == 'sign_in_canceled') {
        logger.d(error.message);
      }
      return LoginPlatform.none;
    } catch (error) {
      logger.d(error);
      return LoginPlatform.none;
    }
  }

  Future<LoginPlatform> signOut(LoginPlatform loginPlatform) async {
    switch (loginPlatform) {
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.kakao:
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
      default:
        break;
    }
    return LoginPlatform.none;
  }
}
