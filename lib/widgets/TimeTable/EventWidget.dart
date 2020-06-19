import 'package:flutter/material.dart';

import 'package:actual/models/Event.dart';

class EventWidget extends StatefulWidget {
  final Event currentEvent;
  final Function deleteEvent;

  EventWidget(this.currentEvent, this.deleteEvent);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  final addedSnackBar = SnackBar(
    content: Text(
      'Event has been completed',
      style: TextStyle(color: Colors.black),
    ),
    duration: new Duration(seconds: 3),
    backgroundColor: Colors.redAccent,
  );

  @override
  Widget build(BuildContext context) {
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
      key: ValueKey(widget.currentEvent.id),
      onDismissed: (direction) {
        setState(() {
          widget.deleteEvent(widget.currentEvent.id);
          Scaffold.of(context).showSnackBar(addedSnackBar);
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Card(
            elevation: 50,
            color: Colors.yellow[200],
            child: ListTile(
              title: Text(
                this.widget.currentEvent.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                this.widget.currentEvent.place,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue[300],
                  // border: Border.all(color: Colors.red),
                ),
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(
                    this.widget.currentEvent.time.format(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
