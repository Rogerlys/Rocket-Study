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
          border: Border.all(color: Colors.blue[50]), shape: BoxShape.circle),
      child: CircleAvatar(
        radius: selectedDay == id ? 32 : 24,
        backgroundColor: selectedDay == id ? Colors.green : Colors.red,
        child: CircleAvatar(
          radius: selectedDay == id ? 30 : 22,
          backgroundColor:
              selectedDay == id ? Colors.greenAccent : Colors.white,
          child: Text(
            weekday[0] + weekday[1],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue[700]),
          ),
        ),
      ),
    );
  }
}
