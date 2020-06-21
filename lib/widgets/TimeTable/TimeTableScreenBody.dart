import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

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
    List<TimelineModel> items = widget.days[widget.selectedDay].events
        .map((x) => TimelineModel(EventWidget(x, widget.delete),
            position: TimelineItemPosition.right,
            iconBackground: Colors.redAccent,
            icon: Icon(Icons.blur_circular)))
        .toList();

    return Row(
      children: <Widget>[
        Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.15,
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
            width: MediaQuery.of(context).size.width * 0.85,
            child: Timeline(children: items, position: TimelinePosition.Left)),
      ],
    );
  }
}
