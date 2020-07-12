import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:tecnoloadershantanumishra/App_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passcode Lock Screen Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleHomePage(),
    );
  }
}
class ExampleHomePage extends StatefulWidget {
  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {

  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '123456' == enteredPasscode;
    _verificationNotifier.add(isValid);
    setState(() {
      this.isAuthenticated = isValid;
    });
    if(isValid){
      Navigator.of(context).push( MaterialPageRoute(

          builder: (context)
          {
            return AppScreen();
          }
      ),
      );
    }
    else
      {
        Text("wrong password");
      }
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PasscodeScreen(
        title: Text(
          'Enter App Passcode',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        passwordEnteredCallback: _onPasscodeEntered,
        cancelButton: Text('cancel'),
        deleteButton:Text('delete'),
        shouldTriggerVerification: _verificationNotifier.stream,
      ),
    );
  }
}
