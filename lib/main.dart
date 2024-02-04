import 'package:flutter/material.dart';
import 'package:whisp/View/Homepage.dart';
import 'package:whisp/View/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginDemo()
    );
  }
}




