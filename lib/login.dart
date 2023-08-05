import 'package:flutter/material.dart';
import 'colors.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
                      onPressed: () {},
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
