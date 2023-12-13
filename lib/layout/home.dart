// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_null_comparison, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_test8/modules/todolist/archives.dart';
import 'package:flutter_application_test8/modules/todolist/donetasks.dart';
import 'package:flutter_application_test8/modules/todolist/tasks.dart';
import 'package:flutter_application_test8/shared/constant/constant.dart';
import 'package:intl/intl.dart';
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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: colors[currentIndex],
        title: Center(child: Text("${titles[currentIndex]}")),
        leading: icons[currentIndex],
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors[currentIndex],
        onPressed: () async {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(() {
                flbIcon = Icons.edit;
              });
            }
          } else {
            scaffoldKey.currentState!.showBottomSheet((context) => Container(
                color: Colors.grey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            prefix: Icons.title,
                            label: "Task Title",
                            validate: (String value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Task Title";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: timeController,
                            type: TextInputType.datetime,
                            prefix: Icons.watch_later_outlined,
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                print(value?.format(context));
                              });
                            },
                            label: "Task Time",
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "Please Enter Task Time";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: dateController,
                            type: TextInputType.datetime,
                            prefix: Icons.calendar_today,
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.parse("2027-01-13"))
                                  .then((value) {
                                dateController.text =
                                    DateFormat.yMMMd().format(value!);

                                print(value.toString());
                              });
                            },
                            label: "Task date",
                            validate: (String value) {
                              if (value == null || value.isEmpty) {
                                return "Date is null or empty";
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                )));
            isBottomSheetShown = true;
            setState(() {
              flbIcon = Icons.add;
            });
          }
          // insertToDatabase();
        },
        child: Icon(flbIcon),
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
    database = await openDatabase("todo.db", version: 1,
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

  void insertToDatabase() {
    database.transaction((txn) {
      return txn
          .rawInsert(
              "INSERT INTO tasks(title, date, time, status) VALUES('first tasks','13/5/1998','20:15','new')")
          .then((value) {
        print("$value inserted successfully");
      }).catchError((onError) {
        print("error inserting ${onError.toString()}");
      });
    });
  }
  ///////////////////////text form widget ///////////////////////////////////////

  Widget defaultFormField({
    required TextEditingController controller,
    required TextInputType type,
    required IconData prefix,
    required String label,
    String hintText = "Enter your Email",
    Function? onSubmit,
    Function? onChange,
    Function? onTap,
    Function? validate,
    Function? suffixPressed,
    bool isPassword = false,
    IconData? suffix,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: (value) {
          onSubmit!(value);
        },
        onChanged: (value) {
          onChange!(value);
        },
        validator: (value) {
          return validate!(value);
        },
        onTap: () {
          onTap!();
        },
        decoration: InputDecoration(
            hintText: hintText,
            labelText: label,
            prefixIcon: Icon(prefix),
            suffixIcon: IconButton(
              onPressed: () {
                suffixPressed!();
              },
              icon: Icon(suffix),
            ),
            border: OutlineInputBorder()),
      );
  //////////////////////////////////////////////////////////////////////
}
