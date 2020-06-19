import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  final int selectedDay;
  final int id;
  final String weekday;

  Day(this.selectedDay, this.id, this.weekday);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: selectedDay == id ? Colors.green : Colors.red, width: 2),
          shape: BoxShape.circle),
      child: CircleAvatar(
        radius: selectedDay == id ? 30 : 22,
        backgroundColor: selectedDay == id ? Colors.greenAccent : Colors.white,
        child: Text(
          weekday[0] + weekday[1],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff2d386b)),
        ),
      ),
    );
  }
}
