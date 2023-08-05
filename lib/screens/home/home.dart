import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constrains) => Container(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(),
              ),
            ));
  }
}
