import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../models/ToDo.dart';

class CompletedTaskScreen extends StatefulWidget {
  static const routeName = '/IncompletedTaskScreen';

  List<ToDo> completedTask;

  CompletedTaskScreen(this.completedTask);

  @override
  _CompletedTaskScreenState createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  var _isInit = true;

  void _deleteAll() {
    final url = 'https://todo-7b300.firebaseio.com/completedTask.json';
    http.delete(url);
    setState(() {
      widget.completedTask.clear();
    });
  }

  Future<void> fetchAndCompletedTask() async {
    const url = 'https://todo-7b300.firebaseio.com/completedTask.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<ToDo> loadedCompletedTask = [];

      if (extractedData != null) {
        extractedData.forEach((id, toDoData) {
          loadedCompletedTask.add(ToDo(
              id: id,
              title: toDoData['title'],
              date: DateTime.parse(toDoData['date'])));
        });
      }

      setState(() {
        widget.completedTask = loadedCompletedTask;
      });
    } catch (error) {
      throw (error);
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchAndCompletedTask();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
            backgroundColor: Colors.grey[200],
            actions: <Widget>[
              IconButton(
                  color: Colors.red,
                  icon: const Icon(Icons.delete),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text(
                                  'This action will delete the entire completed task. Do you still want to proceed?'),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('No')),
                                FlatButton(
                                    onPressed: () {
                                      _deleteAll();
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('Yes'))
                              ]))),
            ],
            title: Text('Completed Tasks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        body: ListView(
            children: widget.completedTask
                .map((item) => CompletedItem(item))
                .toList()));
  }
}

class CompletedItem extends StatelessWidget {
  final ToDo completedItem;

  CompletedItem(this.completedItem);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Card(
          color: Colors.yellow[200],
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          elevation: 5,
          child: ListTile(
            title: Text(
              completedItem.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(completedItem.date),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
