import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explcit
  double amount = 150.0;
  double size = 200.0;

  // Method

  Widget emailTextFormField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email :',
            hintText: 'you@email.com',
          ),
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password :',
            hintText: 'More 6 Charactor',
          ),
        ),
      ),
    );
  }

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
            fontSize: 40.0,
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
            fontFamily: 'RugeBoogie'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(top: 70.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[
            showLogo(),
            showName(),
            emailTextFormField(),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }
}
