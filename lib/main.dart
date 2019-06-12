import 'package:flutter/material.dart';
import 'package:mushroom_iot_ung/screens/authen.dart';
import 'package:mushroom_iot_ung/screens/register.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Register(),
    );
  }
}
