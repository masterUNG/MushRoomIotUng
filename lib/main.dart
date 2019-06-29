import 'package:flutter/material.dart';
import 'package:mushroom_iot_ung/screens/authen.dart';
import 'package:mushroom_iot_ung/screens/my_service.dart';
import 'package:mushroom_iot_ung/screens/register.dart';
import 'package:flutter/services.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => Authen()},
    );
  }
}
