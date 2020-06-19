import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../models/Event.dart';

class NextEvent extends StatelessWidget {
  final Event next;
  NextEvent(this.next);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
          top: 50,
          right: MediaQuery.of(context).size.width * 0.1),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'UPCOMING LESSON',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.yellow,
            thickness: 5,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.21,
              width: MediaQuery.of(context).size.width,
              child: Card(
                  elevation: 20,
                  child: Row(
                    children: <Widget>[
                      Transform.rotate(
                        angle: -3.14/2,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: TimerBuilder.periodic(Duration(seconds: 1),
                                builder: (context) {
                              return Text(
                                "${DateTime.now().hour}" + ":"
                                    "${DateTime.now().minute}" + ":"
                                    "${DateTime.now().second}",
                                style: TextStyle(
                                    color: Color(0xff2d386b),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              );
                            })),
                      ),
                      Flexible(
                          child: Text(
                            "Next Lesson: " +
                                next.title +
                                "\n" +
                                "Time: " +
                                next.time.format(context) +
                                "\n" +
                                "Location: " +
                                next.place,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.5),
                            textAlign: TextAlign.start,
                          )),
                    ],
                  ))),
        ],
      ),
    );
  }
}