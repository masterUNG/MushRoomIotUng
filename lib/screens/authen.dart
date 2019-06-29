import 'package:flutter/material.dart';
import 'package:mushroom_iot_ung/screens/my_service.dart';
import 'package:mushroom_iot_ung/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explcit
  double amount = 150.0;
  double size = 250.0;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String emailString, passwordString;

  // Method
  void showSnackBar(String messageString) {
    SnackBar snackBar = SnackBar(
      content: Text(messageString),
      duration: Duration(seconds: 8),
      backgroundColor: Colors.blue[900],
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.yellow,
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    checkStatus(context);
  }

  void checkStatus(BuildContext context) async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      // Move to MyService
      moveToMyService(context);
    }
  }

  void moveToMyService(BuildContext context) {
    var myServiceRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(myServiceRoute, (Route<dynamic> route) => false);
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 4.0,
      height: 15.0,
    );
  }

  Widget signInButton(BuildContext context) {
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
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            checkAuthen(context);
          }
        },
      ),
    );
  }

  void checkAuthen(BuildContext context) async {
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
      moveToMyService(context);
    }).catchError((objValue) {
      String error = objValue.message;
      print('error => $error');
      showSnackBar(error);
    });
  }

  Widget signUpButton(BuildContext context) {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.blue[700]),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.blue[700]),
        ),
        onPressed: () {
          print('You Click SignUp');

          // Create Route
          var registerRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(registerRoute);
        },
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
            labelStyle: TextStyle(color: Colors.blue[800]),
          ),
          validator: (String value) {
            if (checkSpace(value)) {
              return 'Please Type Email';
            }
          },
          onSaved: (String value) {
            emailString = value;
          },
        ),
      ),
    );
  }

  bool checkSpace(String value) {
    bool result = false; // No Space
    if (value.length == 0) {
      result = true; // Have Space
    }
    return result;
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: size,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password :',
            hintText: 'More 6 Charactor',
            labelStyle: TextStyle(color: Colors.blue[800]),
          ),
          validator: (String value) {
            if (checkSpace(value)) {
              return 'Passwod empty';
            }
          },
          onSaved: (String value) {
            passwordString = value;
          },
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
      key: scaffoldKey,
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
        child: Form(
          key: formKey,
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
                      signInButton(context),
                      mySizeBox(),
                      signUpButton(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
