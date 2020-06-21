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
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Card(
          elevation: 50,
          color: Colors.green[100],
          child: ListTile(
            onLongPress: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text('Are you sure?'),
                      content: Text('Do you want to delete this event?'),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text('No')),
                        FlatButton(
                            onPressed: () {
                              widget.deleteEvent(widget.currentEvent.id);
                              Navigator.of(ctx).pop();
                            },
                            child: Text('Yes'))
                      ],
                    )),
            title: Text(
              this.widget.currentEvent.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              this.widget.currentEvent.place,
            ),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xff2d386b), width: 3),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Text(
                  this.widget.currentEvent.time.format(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2d386b)),
                ),
              ),
            ),
          )),
    );
  }
}
