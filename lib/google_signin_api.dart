import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() {
    return _googleSignIn.signIn();
  }

  static Future logout() async {
    // mysqlauth에서 signout하도록
  }
}
