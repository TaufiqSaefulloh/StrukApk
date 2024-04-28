import 'package:flutter/material.dart';
import 'package:tracking/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      home: LoginPage(),
    );
  }
}
