import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

import 'package:mushroom_iot_ung/screens/show_service.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String nameLogin = "", uidString;
  final formKey = GlobalKey<FormState>();
  int tmpLow, tmpHight, humLow, humHight, suitHum, suitTemp;

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

  bool checkSpace(String value) {
    bool resule = false;
    if (value.length == 0) {
      resule = true;
    }
    return resule;
  }

  Widget tempHeight() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Temp Height :',
          helperText: 'องศา C',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          tmpHight = valueInt;
        },
      ),
    );
  }

  Widget tempLow() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.blue[700]),
            borderRadius: BorderRadius.circular(30.0),
          ),
          labelText: 'Temp Low :',
          helperText: 'องศา C',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          tmpLow = valueInt;
        },
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
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          humHight = valueInt;
        },
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
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          humLow = valueInt;
        },
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
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          suitHum = valueInt;
        },
      ),
    );
  }

  Widget suitAbleTemp() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'SuitAbleTemp :',
          helperText: 'องศา C',
        ),
        validator: (String value) {
          if (checkSpace(value)) {
            return 'Have Space';
          }
        },
        onSaved: (String value) {
          int valueInt = int.parse(value);
          suitTemp = valueInt;
        },
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

  Widget sentButton(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: RaisedButton(
        child: Text('Sent Data'),
        onPressed: () {
          print('You Click sentButton');
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            uploadToFirebase(context);
          }
        },
      ),
    );
  }

  void uploadToFirebase(BuildContext context) async {
    print(
        'TmLow = $tmpLow, TmHighe = $tmpHight, HuLow = $humLow, HuHigt = $humHight, SuitHum = $suitHum, suitTemp = $suitTemp');

    DatabaseReference databaseReference =
        firebaseDatabase.reference().child('IoT');
    await databaseReference.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> map = dataSnapshot.value;
      print('map = $map');

      map['Temp_Low'] = tmpLow;
      map['Temp_High'] = tmpHight;
      map['Humidity_Low'] = humLow;
      map['Humidity_High'] = humHight;
      map['Suitable Humi'] = suitHum;
      map['Suitable Tem'] = suitTemp;

      print('map current = $map');
      sentDataToFirebase(map, context);
    });
  }

  void sentDataToFirebase(Map map, BuildContext context) async {
    await firebaseDatabase.reference().child('IoT').set(map).then((objValue) {
      print('Success');
      var showServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => ShowService());
          Navigator.of(context).push(showServiceRoute);
    }).catchError((objValue) {
      String errorString = objValue.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: showTitle(),
        actions: <Widget>[signOutButton()],
      ),
      body: Form(
        key: formKey,
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              row1(),
              row2(),
              row3(),
              sentButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
