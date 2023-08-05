import 'package:flutter/material.dart';

class Walking extends StatelessWidget {
  const Walking({super.key});

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
