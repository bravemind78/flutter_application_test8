import 'package:flutter/material.dart';
import 'package:flutter_application_test8/layout/home.dart';
import 'package:sqflite/sqflite.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
