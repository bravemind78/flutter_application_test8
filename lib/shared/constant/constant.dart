import 'package:flutter/material.dart';
import 'package:flutter_application_test8/modules/todolist/archives.dart';
import 'package:flutter_application_test8/modules/todolist/donetasks.dart';
import 'package:flutter_application_test8/modules/todolist/tasks.dart';
import 'package:sqflite/sqflite.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
int currentIndex = 0;
List<Widget> screens = [Tasks(), DoneTasks(), ArchivesTasks()];
List<String> titles = ["New Tasks", "Done Tasks", "Archives Tasks"];
List<Icon> icons = [
  Icon(Icons.add),
  Icon(Icons.done),
  Icon(Icons.archive),
];
List<Color> colors = [Colors.orange, Colors.green, Colors.red];
late Database database;
bool isBottomSheetShown = false;
IconData flbIcon = Icons.edit;
var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();
