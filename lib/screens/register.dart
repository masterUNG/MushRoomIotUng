import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mushroom_iot_ung/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  // Method
  Widget uploadButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      iconSize: 36.0,
      onPressed: () {
        print('You Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          uploadToFirebase(context);
        }
      },
    );
  }

  void uploadToFirebase(BuildContext context) async {
    print('Name = $nameString, email = $emailString, pass = $passwordString');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
      String uidString = objValue.uid.toString();
      print('uid ==> $uidString');
      uploadValueToDatabase(uidString, context);
    }).catchError((objValue) {
      String error = objValue.message;
      print('error ==> $error');
    });
  }

  void uploadValueToDatabase(String uid, BuildContext context) async {
    Map<String, String> map = Map();
    map['Name'] = nameString;
    map['Uid'] = uid;

    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    await firebaseDatabase
        .reference()
        .child('User')
        .child(uid)
        .set(map)
        .then((objValue) {
      print('UpdateDatabase Success');

      // Create Route to MyService
      var myServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(myServiceRoute, (Route<dynamic> route) => false);
    }).catchError((objValue) {
      String error = objValue.message;
      print('error ==> $error');
    });
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          color: Colors.blue[700],
          size: 36.0,
        ),
        labelText: 'Name :',
        labelStyle: TextStyle(color: Colors.blue[700]),
        helperText: 'First Name and Last Name',
        helperStyle:
            TextStyle(color: Colors.blue[300], fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.length == 0) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.blue[700],
          size: 36.0,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: Colors.blue[700]),
        helperText: 'you@email.com',
        helperStyle:
            TextStyle(color: Colors.blue[300], fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Type Format Email you@email.com';
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.blue[700],
          size: 36.0,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: Colors.blue[700]),
        helperText: 'More 6 Charactor',
        helperStyle:
            TextStyle(color: Colors.blue[300], fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.length <= 5) {
          return 'Password More 6 Charactor';
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text('Register'),
        actions: <Widget>[uploadButton(context)],
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 80.0, left: 50.0, right: 50.0),
          child: ListView(
            children: <Widget>[nameText(), emailText(), passwordText()],
          ),
        ),
      ),
    );
  }
}
