import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/ToDoList/AppDrawer.dart';
import '../models/ToDo.dart';
import '../widgets/ToDoList/NewToDoItem.dart';
import '../widgets/ToDoList/PieChartDiagram.dart';
import '../widgets/ToDoList/ToDoItem.dart';

class ToDoScreen extends StatefulWidget {
  static const routeName = '/todo-screen';

  List<ToDo> _userToDo;
  final List<ToDo> _completedTask;

  ToDoScreen(this._userToDo, this._completedTask);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  var _isInit = true;

  Future<void> _addNewToDoItem(String title, DateTime deadline) async {
    const url = 'https://todo-7b300.firebaseio.com/todo.json';
    final response = await http.post(url,
        body: json.encode({
          // 'id': DateTime.now().toString(),
          'title': title,
          'date': deadline.toString(),
        }));

    final item = ToDo(
        id: json.decode(response.body)['name'], title: title, date: deadline);

    setState(() {
      widget._userToDo.add(item);
      widget._userToDo.sort((x, y) => x.date.compareTo(y.date));
    });
  }

  void _startAddNewToDoItem(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewToDoItem(_addNewToDoItem);
        });
  }

  void _removeItem(String id) {
    final url = 'https://todo-7b300.firebaseio.com/todo/$id.json';
    http.delete(url);
    setState(() {
      widget._userToDo.removeWhere((item) => item.id == id);
    });
  }

  Future<void> _addToCompletedTask(ToDo completed) async {
    const url = 'https://todo-7b300.firebaseio.com/completedTask.json';
    final response = await http.post(url,
        body: json.encode({
          'title': completed.title,
          'date': completed.date.toString(),
        }));

    final item = ToDo(
        id: json.decode(response.body)['name'],
        title: completed.title,
        date: completed.date);

    setState(() {
      widget._completedTask.add(item);
    });
  }

  @override
  void initState() {
    widget._userToDo.removeWhere(
        (element) => element.date.difference(DateTime.now()).inDays == 0);
    super.initState();
  }

  Future<void> fetchAndSetToDo() async {
    const url = 'https://todo-7b300.firebaseio.com/todo.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<ToDo> loadedToDo = [];
      
      if (extractedData != null) {
        extractedData.forEach((id, toDoData) {
          loadedToDo.add(ToDo(
              id: id,
              title: toDoData['title'],
              date: DateTime.parse(toDoData['date'])));
        });
      }

      setState(() {
        widget._userToDo = loadedToDo;
        widget._userToDo.sort((x, y) => x.date.compareTo(y.date));
      });
    } catch (error) {
      throw (error);
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchAndSetToDo();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Image appBarImage(BuildContext context) {
    // int hour = DateTime.parse("2020-06-13 18:00:04Z").hour;
    int hour = DateTime.now().hour;
    String imageUrl;

    if (hour >= 6 && hour <= 11) imageUrl = 'assets/images/Sunrise.jpg';
    if (hour > 11 && hour <= 16) imageUrl = 'assets/images/Afternoon.jpg';
    if (hour > 16 && hour <= 19) imageUrl = 'assets/images/Sunset.jpg';
    if (hour > 19 || hour < 6) imageUrl = 'assets/images/NightSky.jpg';

    print(DateTime.now());

    return Image.asset(
      imageUrl,
      fit: BoxFit.cover, //can be Boxfit.fill
      height: MediaQuery.of(context).size.height * 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/LightBlue1.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: AppDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[
                GestureDetector(
                    onTap: () => _startAddNewToDoItem(context),
                    child: Icon(Icons.add, color: Colors.white, size: 30)),
                SizedBox(width: 10)
              ],
              backgroundColor: Colors.transparent,
              iconTheme: new IconThemeData(color: Colors.white, size: 20),
              centerTitle: false,
              forceElevated: false,
              expandedHeight: 250,
              floating: true,
              pinned: false,
              title: Text(
                'To-Do List!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      child: appBarImage(context),
                    )),
                    Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: PieChartDiagram(widget._completedTask,
                            widget._userToDo, UniqueKey()))
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              for (var i = 0; i < widget._userToDo.length; i++)
                ToDoItem(widget._userToDo[i], _removeItem, _addToCompletedTask)
            ]))
          ],
        ),
      ),
    );
  }
}
