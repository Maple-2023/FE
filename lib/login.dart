import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
            appBar: AppBar(
              title: Text(
                'Hello Flutter',
                style: TextStyle(fontSize: 28),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'email'),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'password'),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('로그인'),
                    ),
                  )
                ],
              ),
            )));
  }
}
