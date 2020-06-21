import 'package:flutter/material.dart';

import '../../models/Pair.dart';
import '../../widgets/TimeTable/Day.dart';
import '../../widgets/TimeTable/EventWidget.dart';

class TimeTableScreenBody extends StatefulWidget {
  final List<Pair> days;
  final Function delete;
  int selectedDay = DateTime.now().weekday - 1; //default set as today

  TimeTableScreenBody(this.days, this.delete);

  @override
  _TimeTableScreenBodyState createState() => _TimeTableScreenBodyState();
}

class _TimeTableScreenBodyState extends State<TimeTableScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Card(
                color: Colors.transparent,
                elevation: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    for (int i = 0; i < widget.days.length; i++)
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedDay = i;
                            });
                          },
                          child: Day(
                              widget.selectedDay, i, widget.days[i].weekday))
                  ],
                ))),
        Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                for (int i = 0;
                    i < widget.days[widget.selectedDay].events.length;
                    i++)
                  EventWidget(
                      widget.days[widget.selectedDay].events[i], widget.delete)
              ],
            ))),
      ],
    );
  }
}