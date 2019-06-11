import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explcit
  double amount = 150.0;

  // Method
  Widget showLogo() {
    return Container(
      width: amount,
      height: amount,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showName() {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Text(
        'Mush Room IoT',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.blue[800],
          fontWeight: FontWeight.bold, fontFamily: 'RugeBoogie'
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[showLogo(), showName()],
        ),
      ),
    );
  }
}
