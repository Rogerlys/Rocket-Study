import 'dart:convert';

import 'package:actual/models/Pair.dart';
import 'package:actual/widgets/TimeTable/NextEvent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/TimeTable/NewEvent.dart';
import '../models/Event.dart';
import '../widgets/TimeTable/TimeTableScreenBody.dart';

class TimeTableScreen extends StatefulWidget {
  static const routeName = '/TimeTableScreen';
  List<Pair> days;

  TimeTableScreen(this.days);
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTableScreen> {
  var _isInit = true;
  var _isLoading = true;
  var weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

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

  Future<void> addNewEvent(
      String title, TimeOfDay time, String place, int day) async {
    final url = 'https://todo-7b300.firebaseio.com/timetableEvent/$day.json';
    final response = await http.post(url,
        body: json.encode({
          'day': day.toString(),
          'title': title,
          'time of event': time.toString(),
          'location': place
        }));

    setState(() {
      widget.days[day].events
          .add(Event(json.decode(response.body)['name'], title, time, place));
      widget.days[day].events.sort((a, b) => compareTime(a, b));
    });
  }

  void _delete(String id) {
    for (int day = 0; day < 7; day++) {
      http.delete(
          'https://todo-7b300.firebaseio.com/timetableEvent/$day/$id.json');
    }
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

  TimeOfDay convertStringToTimeOfDay(String string) {
    /*
    * String format has to be specifically TimeOfDay(18:23) for example
    */
    int hour = int.parse(string[10] + string[11]);
    int min = int.parse(string[13] + string[14]);
    return TimeOfDay(hour: hour, minute: min);
  }

  Future<void> fetchAndSetEvents() async {
    try {
      final List<Pair> loadedDays = [];

      for (int day = 0; day < 7; day++) {
        final response = await http
            .get('https://todo-7b300.firebaseio.com/timetableEvent/$day.json');
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final List<Event> eventsOfTheDay = [];
        if (extractedData != null) {
          extractedData.forEach((id, eventData) {
            eventsOfTheDay.add(Event(
                id,
                eventData['title'],
                convertStringToTimeOfDay(eventData[
                    'time of event']), //problem is how to change from String to TimeOfDay.
                eventData['location']));
          });
        }
        loadedDays.add(Pair(weekdays[day], eventsOfTheDay));
      }
      setState(() {
        widget.days = loadedDays;
        _isLoading = false;
      });
    } catch (error) {
      throw (error);
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchAndSetEvents();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: Colors.grey[200],
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            floatingActionButton: FloatingActionButton(
              elevation: 20,
              child: Icon(Icons.add),
              onPressed: () => startAddNewEvent(context),
              backgroundColor: Colors.greenAccent,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80)),
                  //Use stack here to add the content at the top which can be the next lesson details.
                  child: _nextLesson() == null
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            'assets/images/ToDoScreenAppBar.jpg',
                            fit: BoxFit.cover, //can be Boxfit.fill
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
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
                ),
                TimeTableScreenBody(widget.days, _delete),
              ],
            ),
          );
  }
}
