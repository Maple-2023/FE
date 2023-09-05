import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './google_signin_api.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {
    GoogleSignInAccount? user = await GoogleSignInApi.login();

    GoogleSignInAuthentication? googleAuth = await user!.authentication;
    var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential != null) {
      print('로그인 성공 === Google');
      print(userCredential);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              GoogleLoggedInPage(userCredential: userCredential)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('로그인 실패 === Google')));
    }

    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
            appBar: AppBar(
              title: Text(
                'Ma Map',
                style: TextStyle(fontSize: 28),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kakao_color),
                      ),
                      child: Text('카카오톡 로그인'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await loginWithGoogle(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text('구글 로그인'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(naver_color),
                      ),
                      child: Text('네이버 로그인'),
                    ),
                  )
                ],
              ),
            )));
  }
}
