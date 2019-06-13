import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String nameLogin = "", uidString;

  // Method
  @override
  void initState() {
    super.initState();
    findUidLogin();
  }

  void findUidLogin() async {
    await firebaseAuth.currentUser().then((objValue) {
      uidString = objValue.uid.toString().trim();
      print('uidString ==> $uidString');
      findNameLogin();
    });
  }

  void findNameLogin() async {
    await firebaseDatabase
        .reference()
        .child('User')
        .child(uidString)
        .once()
        .then((DataSnapshot dataSnapshop) {
      String response = dataSnapshop.value.toString();
      print('response = $response');

      Map<dynamic, dynamic> map = dataSnapshop.value;
      setState(() {
        nameLogin = map['Name'];
      });
      print('nameLogin ==> $nameLogin');
    });
  }

  Widget showTitle() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text('My Service'),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Login by $nameLogin',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        signOut();
      },
    );
  }

  void signOut() async {
    await firebaseAuth.signOut().then((objValue) {
      // Exit App
      exit(0);
    });
  }

  Widget tempHeight() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Temp Height :',
          helperText: 'องศา C',
        ),
      ),
    );
  }

  Widget tempLow() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Temp Low :',
          helperText: 'องศา C',
        ),
      ),
    );
  }

  Widget humudityHeight() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Humudity Height :',
          helperText: 'เปอร์เซ็นความชื้น',
        ),
      ),
    );
  }

  Widget humudityLow() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Humudity Low :',
          helperText: 'เปอร์เซ็นความชื้น',
        ),
      ),
    );
  }

  Widget suitAbleHumudity() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'SuitAbleHumudity :',
          helperText: 'เปอร์เซ็นความชื้น',
        ),
      ),
    );
  }

  Widget suitAbleTemp() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'SuitAbleHumudity :',
          helperText: 'องศา C',
        ),
      ),
    );
  }

  Widget row1() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 300.0,
        child: Row(
          children: <Widget>[tempLow(), tempHeight()],
        ),
      ),
    );
  }

  Widget row2() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 300.0,
        child: Row(
          children: <Widget>[humudityLow(), humudityHeight()],
        ),
      ),
    );
  }

  Widget row3() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        width: 300.0,
        child: Row(
          children: <Widget>[suitAbleHumudity(), suitAbleTemp()],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showTitle(),
        actions: <Widget>[signOutButton()],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[row1(), row2(), row3()],
        ),
      ),
    );
  }
}
