import 'package:flutter/material.dart'; // Import built in UI package
import '../screens/login.dart'; // Import my own coded login page.
/*
  This is the UI that the user is presented with when the application is opened.
  Since each page is represented in an individual class, and we have navigation between pages,
  this page represents the root page. The root page on program launch, needs to launch the LoginPage.
  So the home attribute of the 'MaterialApp' object is set to LoginPage so the application knows
  that it's the root for the navigation.
*/

void main() {
  runApp(PrivChat());
}

class PrivChat extends StatelessWidget {
  PrivChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PrivChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

