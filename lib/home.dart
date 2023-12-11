// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_application_test8/modules/todolist/archives.dart';
import 'package:flutter_application_test8/modules/todolist/donetasks.dart';
import 'package:flutter_application_test8/modules/todolist/tasks.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  void initState() {
    super.initState();
    creatDatabase();
  }

  int currentIndex = 0;
  List<Widget> screens = [Tasks(), DoneTasks(), ArchivesTasks()];
  List<String> titles = ["New Tasks", "Done Tasks", "Archives Tasks"];
  List<Icon> icons = [
    Icon(Icons.add),
    Icon(Icons.done),
    Icon(Icons.archive),
  ];
  List<Color> colors = [Colors.orange, Colors.green, Colors.red];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors[currentIndex],
        title: Center(child: Text("${titles[currentIndex]}")),
        leading: icons[currentIndex],
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors[currentIndex],
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_box_rounded), label: "Done Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: "Archived"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  // Future<String> getName() async {
  //   return "Nader";
  // }
  void creatDatabase() async {
    // ignore: unused_local_variable
    var database = await openDatabase("todo.db", version: 1,
        onCreate: (database, version) {
      database
          .execute(
              "CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT)")
          .then((value) {
        print("table created");
      }).catchError((error) {
        print("error creating table ${error.String()}");
      });
    }, onOpen: (database) {
      print("database opened");
    });
  }
}
