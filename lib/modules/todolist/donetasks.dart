// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Done Tasks",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
