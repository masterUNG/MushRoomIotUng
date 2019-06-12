import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      iconSize: 36.0,
      onPressed: () {},
    );
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
              TextStyle(color: Colors.blue[300], fontStyle: FontStyle.italic)),
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
              TextStyle(color: Colors.blue[300], fontStyle: FontStyle.italic)),
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
              TextStyle(color: Colors.blue[300], fontStyle: FontStyle.italic)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text('Register'),
        actions: <Widget>[uploadButton()],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 80.0, left: 50.0, right: 50.0),
        child: ListView(
          children: <Widget>[nameText(), emailText(), passwordText()],
        ),
      ),
    );
  }
}
