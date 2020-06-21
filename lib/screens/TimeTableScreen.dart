import 'package:actual/models/Pair.dart';
import 'package:actual/widgets/TimeTable/NextEvent.dart';
import 'package:flutter/material.dart';

import '../widgets/TimeTable/NewEvent.dart';
import '../models/Event.dart';
import '../widgets/TimeTable/TimeTableScreenBody.dart';

class TimeTableScreen extends StatefulWidget {
  static const routeName = '/TimeTableScreen';
  final List<Pair> days;

  TimeTableScreen(this.days);
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTableScreen> {
  void startAddNewEvent(BuildContext cxt) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: cxt,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: NewEvent(addNewEvent),
          );
        });
  }

  int compareTime(Event a, Event b) {
    double timeA = a.time.hour + a.time.minute / 60.0;
    double timeB = b.time.hour + b.time.minute / 60.0;
    return timeA > timeB ? 1 : -1;
  }

  void addNewEvent(String title, TimeOfDay time, String place, int day) {
    setState(() {
      widget.days[day].events
          .add(Event(DateTime.now().toString(), title, time, place));
      widget.days[day].events.sort((a, b) => compareTime(a, b));
    });
  }

  void _delete(String id) {
    setState(() {
      for (int i = 0; i < 7; i++) {
        widget.days[i].events.removeWhere((x) => x.id == id);
      }
    });
  }

  Event _nextLesson() {
    int current = DateTime.now().weekday - 1;
    for (int i = 0; i < 7; i++) {
      if (current >= 6) {
        current = 0;
      } else {
        current++;
      }
      List<Event> temp = widget.days[current].events;
      int now = DateTime.now().hour * 60 + DateTime.now().minute;
      if (current == DateTime.now().weekday - 1) {
        for (int j = 0; j < temp.length; j++) {
          int eventTime = temp[j].time.hour * 60 + temp[j].time.minute;
          if (now < eventTime) {
            return temp[j];
          }
        }
      } else {
        if (temp.length > 0) {
          return temp[0];
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        child: Icon(Icons.add),
        onPressed: () => startAddNewEvent(context),
        backgroundColor: Colors.greenAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80)),
              //Use stack here to add the content at the top which can be the next lesson details.
              child: _nextLesson() == null
                  ? Image.asset(
                      'assets/images/ToDoScreenAppBar.jpg',
                      fit: BoxFit.cover, //can be Boxfit.fill
                    )
                  : Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/ToDoScreenAppBar.jpg',
                            fit: BoxFit.cover, //can be Boxfit.fill
                          ),
                        ),
                        NextEvent(_nextLesson())
                      ],
                    ),
            ),
            SizedBox(height: 10),
            TimeTableScreenBody(widget.days, _delete),
          ],
        ),
      ),
    );
  }
}
