import 'package:flutter/material.dart';
import '../screens/login.dart';

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

