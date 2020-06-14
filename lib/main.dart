import 'package:actual/screens/StickyNotesScreen.dart';
import 'package:flutter/material.dart';

import './screens/ToDoScreen.dart';
import './screens/TimeTableScreen.dart';
import './screens/HomePageScreen.dart';
import './screens/CompletedTaskScreen.dart';
import './models/ToDo.dart';
import './models/Pair.dart';
import './models/Event.dart';
import './widgets/StickNotes/Note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<ToDo> _userToDo = [];

  final List<ToDo> _completedTask = [];

  final List<Pair> _days = [
    Pair("Monday", [

    ]),
    Pair("TuesDay", []),
    Pair("Wednesday", []),
    Pair("Thursday", []),
    Pair("Friday", []),
    Pair("Saturday", []),
    Pair("Sunday", []),
  ];
  List<Widget> notes = [
      Note("Title 1", "passage 1"),
      Note("Title 2", "passage 1"),
      Note("Title 3", "passage 1"),
      Note("Title 4", "passage 1"),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[100],
        accentColor: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageScreen(),
      routes: {
        ToDoScreen.routeName: (ctx) => ToDoScreen(_userToDo, _completedTask),
        TimeTableScreen.routeName: (ctx) => TimeTableScreen(_days),
        CompletedTaskScreen.routeName: (ctx) =>
            CompletedTaskScreen(_completedTask),
        StickNotesScreen.routeName: (ctx) => StickNotesScreen(notes),
      },
    );
  }
}
