import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explcit
  double amount = 150.0;
  double size = 250.0;

  // Method

  Widget mySizeBox() {
    return SizedBox(
      width: 4.0,
      height: 15.0,
    );
  }

  Widget signInButton() {
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.blue[700],
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signUpButton() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.blue[700]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.blue[700]),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget emailTextFormField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Email :',
              hintText: 'you@email.com',
              labelStyle: TextStyle(color: Colors.blue[800])),
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
              labelStyle: TextStyle(color: Colors.blue[800])),
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0),
            colors: [
              Colors.white,
              Colors.blue[700],
            ],
            radius: 1.5,
          ),
        ),
        padding: EdgeInsets.only(top: 70.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[
            showLogo(),
            mySizeBox(),
            showName(),
            emailTextFormField(),
            passwordTextFormField(),
            mySizeBox(),
            Container(
              alignment: Alignment.center,
              child: Container(
                width: size,
                child: Row(
                  children: <Widget>[
                    signInButton(),
                    mySizeBox(),
                    signUpButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
