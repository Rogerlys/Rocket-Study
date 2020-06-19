import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:actual/models/ToDo.dart';

class ToDoItem extends StatefulWidget {
  final ToDo toDo;
  final Function removeItem;
  final Function completed;

  ToDoItem(this.toDo, this.removeItem, this.completed);

  @override
  _ToDoItemState createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  Color colorCode(DateTime deadline) {
    final timeDifference = deadline.difference(DateTime.now()).inDays;
    if (timeDifference < 2) {
      return Colors.red[700];
    } else if (timeDifference < 4) {
      return Colors.red[300];
    } else {
      return Colors.transparent;
    }
  }

  final deleteSnackBar = SnackBar(
    content: Text(
      'Item has been deleted',
      style: TextStyle(color: Colors.black),
    ),
    duration: new Duration(seconds: 3),
    backgroundColor: Colors.redAccent,
  );

  final addedSnackBar = SnackBar(
    content: Text(
      'Item has been completed',
      style: TextStyle(color: Colors.black),
    ),
    duration: new Duration(seconds: 3),
    backgroundColor: Colors.greenAccent,
  );

  @override
  Widget build(BuildContext context) {
    var card = ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Card(
          color: Colors.blue[50],
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          elevation: 10,
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: colorCode(widget.toDo.date),
              ),
              height: 50,
              width: 70,
              child: Text(
                  widget.toDo.date
                          .difference(DateTime.now())
                          .inDays
                          .toString() +
                      '\n days',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            title: Text(
              widget.toDo.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(widget.toDo.date),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              color: Colors.green,
              iconSize: 32,
              icon: const Icon(Icons.assignment_turned_in),
              onPressed: () {
                widget.removeItem(widget.toDo.id);
                widget.completed(widget.toDo);
                Scaffold.of(context).showSnackBar(addedSnackBar);
              },
            ),
          )),
    );

    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).errorColor,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      key: ValueKey(widget.toDo.id),
      onDismissed: (direction) {
        setState(() {
          widget.removeItem(widget.toDo.id);
          Scaffold.of(context).showSnackBar(deleteSnackBar);
        });
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('Do you want to remove the item from the list?'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('No')),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Yes'))
                  ],
                ));
      },
      child: card,
    );
  }
}
