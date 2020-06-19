import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:actual/models/ToDo.dart';

class PieChartDiagram extends StatefulWidget {
  final List<ToDo> completedTask;
  final List<ToDo> userToDo;
  final Key key; //The key is for the parent widget ToDoScreen. So whenever adding/deleting, the piechart will reload.

  PieChartDiagram(this.completedTask, this.userToDo, this.key);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChartDiagram> {
  Map<String, double> data = new Map();

  void initState() {
    data.addAll({
      'Completed Task': widget.completedTask.length.toDouble(),
      'Ongoing Task': widget.userToDo.length.toDouble(),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        height: 180,
        child: PieChart(
          animationDuration: Duration(milliseconds: 1500),
          chartLegendSpacing: 35.0,
          chartRadius: MediaQuery.of(context).size.width / 2.7,
          showChartValues: true,
          showChartValuesOutside: false,
          chartValueBackgroundColor: Colors.grey[200],
          legendPosition: LegendPosition.right,
          decimalPlaces: 2,
          showChartValueLabel: true,
          initialAngle: 0,
          dataMap: data,
          showLegends: true,
          legendStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }
}


